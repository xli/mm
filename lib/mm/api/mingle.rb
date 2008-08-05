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
  class API
    module Mingle
      def team_members
        return @team_members if defined?(@team_members)
        init(Resource::Mingle::User)
        @team_members = Resource::Mingle::User.find(:all)
      end
  
      def property_definitions
        return @property_definitions if defined?(@property_definitions)
        init(Resource::Mingle::PropertyDefinition)
        @property_definitions = Resource::Mingle::PropertyDefinition.find(:all)
      end
  
      def favorites
        return @favorites if defined?(@favorites)
        init(Resource::Mingle::Favorite)
        @favorites = Resource::Mingle::Favorite.find(:all)
      end
    
      def create_transition_execution(attrs)
        init(Resource::Mingle::TransitionExecution)
        Resource::Mingle::TransitionExecution.create(attrs)
      end
  
      def find_card(options={})
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(:first, options)
      end
    
      def find_card_by_number(number)
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(number)
      end
    
      def find_cards(options={})
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(:all, :params => options)
      end
    
      def init(klass)
        klass.site = @runtime[:site]
      end
    
      def execute_cmd(cmd)
        %x[#{cmd}]
      end
    end
  end
end
