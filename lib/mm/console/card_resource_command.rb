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
    class CardResourceCommand
      def initialize(command, card_resource)
        @command = command
        @card_resource = card_resource
      end
      
      def execute(runtime)
        case
        when @card_resource.respond_to?(@command)
          @card_resource.send(@command)
        when prop = (runtime[:api].property_definitions || []).detect{|prop_def| prop_def.name.downcase == @command}
          @card_resource.send(prop.column_name)
        when runtime[@command.to_sym]
          MM::Console::Processor.new(runtime).process(runtime[@command.to_sym])
        else
          MM::Console::Transition.new(:command => @command, :card_number => @card_resource.number).execute(runtime)
        end
      end
    end
  end
end