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
        runtime[:selecting_list] = MM::Console::SelectingList.new(names, MM::Console::RuntimeVariables::Value)
      end
    end
  end
end