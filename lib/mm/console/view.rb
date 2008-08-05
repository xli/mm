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
  module Console
    class View
      
      class Context
        def initialize(view_name, cards)
          @view_name = view_name
          @cards = cards
        end
        
        def push(tokens)
          tokens.push [:VIEW_RESOURCE, @view_name]
        end
        
        def to_s
          "#{@view_name}"
        end
      end
      
      def initialize(view_name)
        @view_name = view_name
      end
      
      def execute(runtime)
        if @cards = runtime[:api].find_cards(:view => @view_name)
          runtime[:context] = Context.new(@view_name, @cards)
          runtime[:selecting_list] = MM::Console::SelectingList.new(@cards, MM::Console::Card)
          @cards.collect(&:to_s)
        end
      end
    end
  end
end