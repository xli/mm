module MM
  module Console
    module SimpleCommand
      class RuntimeVariables
        class Value
          def initialize(name)
            @name = name
          end

          def execute(runtime)
            runtime[@name]
          end
        end

        include Base
        def self.keys
          ['variables', 'v']
        end

        def self.doc(runtime)
          "show existed runtime variables\n   How to set a variable? example: fixed = 'complete fix'\n   How to unset a variable? example: fixed = ''"
        end

        def execute(runtime)
          names = runtime.keys.sort_by{|n|n.to_s}
          runtime[:list] = SelectingList.new(names, Value)
        end
      end
    end
  end
end