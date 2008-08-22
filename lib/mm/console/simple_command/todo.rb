module MM
  module Console
    module SimpleCommand
      class ToDo
        class Event
          def initialize(task)
            @task = task
          end
          
          def execute(runtime)
            @task.next(runtime)
            runtime[:list]
          end
        end
        
        class Task
          def initialize(detail)
            @detail = detail
            @status = []
            @status << {:desc => 'todo', :next_action => 'start_work', :at => Time.now}
          end
          
          def next(runtime)
            send(@status.last[:next_action], runtime)
          end
          
          def start_work(runtime)
            @status << {:desc => 'working on', :next_action => 'complete', :at => Time.now}
          end
          
          def complete(runtime)
            @status << {:desc => 'completed', :next_action => 'delete', :at => Time.now}
          end
          
          def delete(runtime)
            runtime[:todo].delete(self)
          end
          
          def to_s
            "#{@status.last[:next_action].titleize}: #{@detail}"
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
            todo_list(runtime) << Task.new(@todo)
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