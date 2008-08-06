module MM
  module Console
    
    module Sections
      def quick_start(runtime)
%Q{ 1) Set a variable named site, for integrating with Mingle project.
   - Example: site = 'http://login:password@mingle.domain.com/projects/project_identifier'
   - Once it is setted, you'll see your project_identifier in the prompt.
 2) Type 'tabs' to view all tabs in your project
   - You can select tab by index to view card list of the tab
 3) Type 'Start fix #1'
   - Run transition 'Start fix' on card number of which is 1
   - The context would be changed to card 1, so that you can view details of the card directly
 4) Type 'properties'
   - Show all card properties have value
 5) Type 'description'
   - Show card 1 description, it is plain text.
 6) Type any property name of card
   - Show property value of the card
 7) Normally, we may have complex transition need to run after you fixed bug. 
   - For example, we have a transition called 'Complete fix', which need you type in revision number after you fixed the bug.
   - To run this transition, you can type: Complete fix #1 with revision => \#{revision}
   - When mm context is card 1, the script can be: Complete fix with revision => \#{revision}.
   - You can use runtime variable to store the transition script: fixed = 'Complete fix with revision => \#{revision}'
 8) Type '`svn commit -m "[fixed]: some details"', after you fixed the bug
   - Any command start with '`' would be run as system command out of mm console
   - Specify runtime variable in '[' and ']'
   - This command will do the followings:
     - run svn commit to commit code with message "Complete fix #1: some details"
     - parse output of svn command to get revision number, for example, this time we get 25
     - run transition: Complete fix #1 with revision => 25
}
      end
      
      def basic_commands(runtime)
        Processor::REGISTERED_COMMANDS.collect do |cmd|
          r = " - #{cmd[:instance].class.name.titleize.split('/').last}: #{cmd[:instance].doc(runtime)}\n"
          r << "   - key: #{cmd[:key]}\n"
          r << "   - short key: #{cmd[:short_key]}\n" if cmd[:short_key]
          r
        end.join("\n")
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
