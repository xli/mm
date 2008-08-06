module MM
  module Console
    class RuntimeVariables
      class Value
        def initialize(name)
          @name = name
        end

        def execute(runtime)
          runtime[@name]
        end
      end

      def execute(runtime)
        names = runtime.keys.sort_by{|n|n.to_s}
        runtime[:selecting_list] = SelectingList.new(names, MM::Console::RuntimeVariables::Value)
      end
      
      def doc(runtime)
        "show existed runtime variables\n   How to set a variable? example: fixed = 'complete fix'\n   How to unset a variable? example: fixed = ''"
      end
    end
    
    Processor.register(:key => 'variables', :short_key => 'v', :instance => RuntimeVariables.new)
  end
end