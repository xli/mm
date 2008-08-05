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
    class Transition
      def initialize(options)
        @command = options[:command]
        @card_number = options[:card_number]
        @properties = options[:properties]
        @comment = options[:comment]
      end
      
      def desc
        "#{@command} ##{@card_number}"
      end
      
      def execute(runtime)
        attrs = {:transition => @command, :card => @card_number, :properties => @properties, :comment => @comment}
        returning runtime[:api].create_transition_execution(attrs) do |str|
          MM::Console::Card.new(@card_number).execute(runtime)
        end
      end
    end
  end
end