module MM
  module Console
    class Transition
      def initialize(options)
        @command = options[:command]
        @card_number = options[:card_number]
        @properties = options[:properties]
        @comment = options[:comment]
      end
      
      def desc
        "#{@command} ##{@card_number}"
      end
      
      def execute(runtime)
        attrs = {:transition => @command, :card => @card_number, :properties => @properties, :comment => @comment}
        returning runtime[:api].create_transition_execution(attrs) do |str|
          MM::Console::Card.new(@card_number).execute(runtime)
        end
      end
    end
  end
end