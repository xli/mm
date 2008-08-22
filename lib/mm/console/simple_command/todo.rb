module MM
  module Console
    module SimpleCommand
      class ToDo
        FIRST_STATUS = 'Start work on'
        
        class Event
          STATUS = {FIRST_STATUS => 'Complate'}
          
          def initialize(todo)
            @todo = todo
            @todo =~ /^([\w\s]+): (.+)/
            @status = $1
            @task = $2
          end
          
          def execute(runtime)
            runtime[:todo].replace(@todo, "#{STATUS[@status]}: #{@task}")
          end
        end
        
        include Base
        
        def self.keys
          ['todo( (.+))?']
        end
        def self.doc(runtime)
          "manage your todo list based on context"
        end
        
        def initialize(todo=nil)
          @todo = todo.gsub(/^todo/, '').strip
        end

        def execute(runtime)
          unless @todo.blank?
            todo_list(runtime) << "#{FIRST_STATUS}: #{@todo}"
          end
          runtime[:list] = todo_list(runtime)
        end
        
        def todo_list(runtime)
          runtime[:todo] ||= SelectingList.new([], Event)
        end
      end
    end
  end
end