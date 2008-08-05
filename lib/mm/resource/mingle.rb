# Copyright (c) 2008 Li Xiao
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
