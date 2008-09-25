module MM
  module Console
    module SimpleCommand
      class Help
        include Base
      
        def self.keys
          ['help']
        end
      
        def self.doc(runtime)
          "show this doc"
        end

        def execute(runtime)
          sections = Sections.instance_methods.sort.collect(&:titleize)
          runtime[:list] = SelectingList.new(sections, Section)
        end
      end

      module Sections
        def quick_start(runtime)
%Q{
  * Set a variable named site, for integrating with Mingle project.
    - Example: site = 'http://login:password@mingle.domain.com/projects/project_identifier'
    - Once it is setted, you'll see your project_identifier in the prompt.
  * Type 'tabs' to view all tabs in your project
    - You can select tab by index to view card list of the tab
  * Type 'Start fix #1'
    - Run transition 'Start fix' on card number of which is 1
    - The context would be changed to card 1, so that you can view details of the card directly
  * Type 'properties'
    - Show all card properties have value
  * Type 'description'
    - Show card 1 description, it is plain text.
  * Type any property name of card
    - Show property value of the card
  * Normally, we may have complex transition need to run after you fixed bug. 
    - For example, we have a transition called 'Complete fix', which need you type in revision number after you fixed the bug.
    - To run this transition, you setup a transition script: Complete fix #1 with revision => \#{revision}
    - When mm context is card 1, the script can be: Complete fix with revision => \#{revision}.
    - You can use runtime variable to store the transition script: fixed = 'Complete fix with revision => \#{revision}'
  * Type '`svn commit -m "[fixed]: some details"', after you fixed the bug
    - Any command start with '`' would be run as system command out of mm console
    - On Mac OS, or any system that command 'which' works, you don't need start with '`' unless the system command is conflic with something inside MM e.g. card attribute name, transition name.
    - Specify runtime variable in '[' and ']'
    - This command will do the followings:
      - run svn commit to commit code with message "Complete fix #1: some details"
      - parse output of svn command to get revision number, for example, this time we get 25
      - run transition: Complete fix #1 with revision => 25
}
        end

        def basic_commands(runtime)
          Processor::REGISTERED_COMMANDS.collect do |cmd|
            r = " - #{cmd.name.titleize.split('/').last}: #{cmd.doc(runtime)}\n"
            r << "   - command keys or match pattern: #{cmd.keys.join(", ")}\n"
            r
          end.join("\n")
        end

        def transition(runtime)
          %{Run Mingle Transition script grammar: 
  1. <transition name> <card number> with <properties> <comment>
  2. card number: #number
  3. properties: <property_name> => <property_value>, <property_name> => <property_value>
  4. comment: (comment content)
  5. examples
    * Run transition 'Start development' on card 4012: Start development #4012
    * Run transition 'Start development' on card 4012 and set required user input property owner to xli: Start development #4012 with owner => xli
    * Run transition 'Start development' on card 4012 and add a comment to card: Start development #4012 (comment detail)
  6. if current context is the card you want to apply the transition, you don't need specify the <card number>, for example:
    * Run transition 'Start development' on card 4012: mingle> story 4012> Start development
}
        end
        
        def context(runtime)
          %{Context is something MM remembered for you. There are 2 kinds of context, one is card, another is view. Context will be displayed as prompt, so that you can know what's context you have currently. For example, if your context is a card, you can simply type in 'open' to open the card in your default browser.
}
        end
        
        def variables(runtime)
          "MM is built in runtime variables, type 'v' to #{Console::SimpleCommand::RuntimeVariables.doc(runtime)}"
        end
        
        def integrating_with_mingle(runtime)
          %{You need setup a variable in the MM console named site for your mingle project url with your login name and password, see the following example log how to setup it:
  >>>
  mm, version 0.0.3
  Type 'help' for usage
  > > site='http://your_login:your_password@your_mingle_server.com/projects/your_project_identifier'
  http://your_login:your_password@your_mingle_server.com/projects/your_project_identifier
  your_project_identifier> >

}
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
    end
  end
end
