module MM
  module Console
    module SimpleCommand
      class RuntimeVariables
        class Value
          def initialize(name)
            @name = name
          end

          def execute(runtime)
            if runtime[@name].kind_of?(SelectingList)
              runtime[:list] = runtime[@name]
            end
            runtime[@name]
          end
        end

        include Base
        def self.keys
          ['variables', 'v']
        end

        def self.doc(runtime)
          "show existed runtime variables\n   How to set a variable? example: fixed = 'complete fix'\n   How to unset a variable? example: fixed = ''\n   MM stores most of stuff as variables so that you can easily access them."
        end

        def execute(runtime)
          names = runtime.keys.sort_by{|n|n.to_s}
          runtime[:list] = SelectingList.new(names, Value)
        end
      end
    end
  end
end