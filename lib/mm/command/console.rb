
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
          if @runtime[:debug]
            puts ''
            puts '---------- debug -----------'
            puts $!.backtrace.join("\n") 
            puts ''
          end
        end
      end
      
      def project
        @runtime[:site].to_s.split('/').last
      end
    end
  end
end