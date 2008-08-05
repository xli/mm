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
    class SelectingList
      def initialize(list, handle_item_class)
        @list = list
        @handle_item_class = handle_item_class
      end
      
      def select_by_index(runtime, index)
        if @list[index]
          @handle_item_class.new(@list[index]).execute(runtime)
        else
          raise "Did I surppose you to select #{index}?"
        end
      end
      
      def to_s
        if @list.blank?
          '! > Nothing.'
        else
          ret = []
          @list.each_with_index do |obj, index|
            ret << "#{index}) #{obj}"
          end
          ret << ''
          ret << "! > Type index number to select item from list."
          ret.join("\n")
        end
      end
    end
    
    class Processor
      class EmptyContext
        def push(tokens)
        end
        def to_s
        end
      end
      
      def initialize(runtime)
        @runtime = runtime
        @runtime[:context] ||= EmptyContext.new
        @simple_commands = {'tabs' => MM::Console::Tabs.new}
      end
      
      def parse(input)
        @simple_commands[input] || ::MMLanguageParser.new.parse(input, @runtime)
      end
      
      def process(input)
        mml = parse(input)
        mml.execute(@runtime)
      end
    end
  end
end