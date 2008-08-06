module MM
  module Console
    
    module Sections
      def quick_start(runtime)
        'quick_start'
      end
      
      def basic_commands(runtime)
        Processor::REGISTERED_COMMANDS.collect do |cmd|
          r = " - #{cmd[:instance].class.name.titleize.split('/').last}: #{cmd[:instance].doc(runtime)}\n"
          r << "   key: #{cmd[:key]}\n"
          r << "   short key: #{cmd[:short_key]}\n" if cmd[:short_key]
          r
        end.join("\n")
      end
      
      def runtime_variable(runtime)
        'runtime_variable'
      end
      
      def transition(runtime)
        'transition'
      end
    end
    
    class Section
      include Sections
      
      def initialize(name)
        @name = name
      end
      
      def execute(runtime)
        send(@name.downcase.split(' ').join('_'), runtime)
      end
      
    end
    
    class Help
      def execute(runtime)
        sections = Sections.instance_methods.sort.collect(&:titleize)
        runtime[:selecting_list] = SelectingList.new(sections, Section)
      end
      
      def doc(runtime)
        "show this doc"
      end
    end
    
    Processor.register(:key => 'help', :instance => Help.new)
  end
end
