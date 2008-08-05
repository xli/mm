module MM
  module Console
    class CardResourceCommand
      def initialize(command, card_resource)
        @command = command
        @card_resource = card_resource
      end
      
      def execute(runtime)
        case
        when @command =~ /^properties$/
          (runtime[:api].property_definitions || []).inject({}) do |map, prop|
            if value = CardResourceCommand.new(prop.column_name, @card_resource).execute(runtime)
              map[prop.name.to_sym] = value
            end
            map
          end
        when @card_resource.respond_to?(@command)
          @card_resource.send(@command)
        when prop = (runtime[:api].property_definitions || []).detect{|prop_def| prop_def.name.downcase == @command}
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
          MM::Console::Processor.new(runtime).process(runtime[@command.to_sym])
        else
          MM::Console::Transition.new(:command => @command, :card_number => @card_resource.number).execute(runtime)
        end
      end
    end
  end
end
