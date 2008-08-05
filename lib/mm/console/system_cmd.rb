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
    class SystemCmd
      SCRIPT_REGEX = /\[([^\]]+)\]/
      
      def initialize(command)
        @command = command
      end
      
      def execute(runtime)
        if @command =~ SCRIPT_REGEX
          @inside_script = runtime[$1.to_sym] || $1
          cmd = processor(runtime).parse(@inside_script)
          if cmd.is_a?(MM::Console::Transition)
            @command.gsub!(SCRIPT_REGEX, cmd.desc)
          else
            @inside_script = nil
          end
        end
        exitstatus, output = runtime[:api].execute_cmd(@command)
        runtime[:revision] = output.to_s.split("\n").last.gsub(/[^0-9]/, '')
        if exitstatus == 0 && defined?(@inside_script) && !@inside_script.blank?
          processor(runtime).process(@inside_script)
        else
          output
        end
      end
      
      def processor(runtime)
        MM::Console::Processor.new(runtime)
      end
    end
  end
end