module MM
  module Console
    
    class CardTransition
      def initialize(transition_name)
        @transition_name = transition_name
      end
      
      def execute(runtime)
        runtime[:context].execute_transition(@transition_name, runtime)
      end
    end
    
    class CardResourceCommand
      def initialize(command, card_resource)
        @command = command
        @card_resource = card_resource
      end
      
      def execute(runtime)
        case
        when @command =~ /^transitions$/
          runtime[:list] = MM::Console::SelectingList.new(runtime[:api].card_transitions(@card_resource), MM::Console::CardTransition)
        when @command =~ /^properties$/
          (runtime[:api].property_definitions || []).inject({}) do |map, prop|
            if value = CardResourceCommand.new(prop.column_name, @card_resource).execute(runtime)
              map[prop.name.to_sym] = value
            end
            map
          end
        when @card_resource.respond_to?(@command)
          @card_resource.send(@command)
        when prop = find_property_definition(runtime, @command)
          value = @card_resource.send(prop.column_name)
          case prop.data_type
          when 'user'
            if member = runtime[:api].team_members.detect{|m| m.id == value}
              value = member.name
            end
          when 'card'
            if card = runtime[:api].find_card_by_number(value)
              value = card.name
            end
          end
          value
        when runtime[@command.to_sym]
          NoResourceCommand.new(@command).execute(runtime)
        else
          Transition.new(:command => @command, :card_number => @card_resource.number).execute(runtime)
        end
      end
      
      def find_property_definition(runtime, name)
        (runtime[:api].property_definitions || []).detect{|prop_def| prop_def.name.downcase == name.downcase}
      end
    end
  end
end
