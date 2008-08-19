module MM
  module Console
    module SimpleCommand
      module Base
        def self.included(base)
          base.class.send(:include, ClassMethods)
          Processor.register(base)
        end
      
        module ClassMethods
          def instance(*args)
            begin
              new(*args)
            rescue ArgumentError
              new
            end
          end

          def keys
            []
          end

          def self.doc(runtime)
            "This command doesn't have any doc yet."
          end

          def map?(input)
            keys.any?{|key| /^#{key}$/ =~ input}
          end
        end
      
        def execute(runtime)
          raise 'implemented by subclass'
        end
      end
    end
  end
end