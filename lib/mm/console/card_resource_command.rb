module MM
  module Console
    class CardResourceCommand
      def initialize(command, card_resource)
        @command = command
        @card_resource = card_resource
      end
      
      def execute(runtime)
        case
        when @card_resource.respond_to?(@command)
          @card_resource.send(@command)
        when prop = (runtime[:api].property_definitions || []).detect{|prop_def| prop_def.name.downcase == @command}
          @card_resource.send(prop.column_name)
        when runtime[@command.to_sym]
          MM::Console::Processor.new(runtime).process(runtime[@command.to_sym])
        else
          MM::Console::Transition.new(:command => @command, :card_number => @card_resource.number).execute(runtime)
        end
      end
    end
  end
end
