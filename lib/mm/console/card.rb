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
    class Card
      
      class Context
        def initialize(card)
          @card = card
        end
        
        def push(tokens)
          tokens.push [:CARD_RESOURCE, @card]
        end
        
        #don't use Delegator, which has problem with store this object instance as yaml
        def method_missing(method, *args, &block)
          if @card.respond_to?(method)
            @card.send(method, *args, &block)
          else
            super
          end
        end
        
        def to_s
          "#{@card.card_type_name} #{@card.number}"
        end
      end
      
      attr_reader :number
      
      def initialize(number, attrs=nil)
        @number = number
        @attrs = attrs
      end
      
      def execute(runtime)
        if card = @number.kind_of?(ActiveResource::Base) ? @number : runtime[:api].find_card_by_number(@number)
          runtime[:context] = Context.new(card)
          if @attrs.blank?
            card
          else
            @attrs.inject({}) do |map, att|
              map[att.to_sym] = MM::Console::CardResourceCommand.new(att, card).execute(runtime)
              map
            end
          end
        else
          raise "Couldn't find card by number #{@number}"
        end
      end
    end
  end
end