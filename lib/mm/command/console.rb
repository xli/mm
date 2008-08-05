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
require 'readline'

module MM
  module Command
    class Console
      def run
        @runtime = MM::RuntimeRepository.load
        @runtime[:api] = MM::API.new(@runtime)
        at_exit {
          @runtime.delete(:api)
          MM::RuntimeRepository.save(@runtime)
          puts 'Bye'
        }
        loop do
          do_once
        end
      end

      def do_once
        prompt = "#{project}> #{@runtime[:context]}> "
        input = Readline.readline(prompt, true).strip
        return if input.blank?
        exit(0) if input =~ /^(exit|quit)$/i
        begin
          puts MM::Console::Processor.new(@runtime).process(input)
        rescue
          puts "mm: #{$!.message}"
        end
      end
      
      def project
        @runtime[:site].to_s.split('/').last
      end
    end
  end
end