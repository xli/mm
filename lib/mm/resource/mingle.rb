module MM
  module Resource
    module Mingle
      class Card < ActiveResource::Base
        def to_s
          "##{number} #{name}"
        end
      
        def file_name
          "#{escape card_type_name} ##{number} #{escape(name)}.card"
        end
      
        def escape(str)
          str.gsub(/[;\/\\]/, '_')
        end
    
        def summarization
<<-SUMMARIZATION
#{short_desc}

#{description}

SUMMARIZATION
        end

        def transitions(runtime)
          @transitions ||= runtime[:api].card_transitions(self) || []
        end
      end

      class PropertyDefinition < ActiveResource::Base
      end

      class Project < ActiveResource::Base
      end

      class User < ActiveResource::Base
      end

      class TransitionExecution < ActiveResource::Base
      end

      class Transition < ActiveResource::Base
      end

      class Favorite < ActiveResource::Base
      end
    end
  end
end
