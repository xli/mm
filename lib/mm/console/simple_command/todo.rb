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
          COLORS = {
            :red => 31, :green => 32, :yellow => 33, :blue => 34, :pink => 35, :sky_blue => 36, :gray => 90,
            :b_red => 41, :b_green => 42, :b_yellow => 43, :b_blue => 44, :b_pink => 45, :b_sky_blue => 46
          }
          FONT_STYLES = {:normal => 0, :bold => 1, :white => 2, :underscore => 4, :flash => 5, :inverse => 7}

          def initialize(detail)
            @detail = detail
            @status = []
            @status << {:desc => 'todo', :next_action => 'start_work', :at => Time.now, :color => :normal}
          end
          
          def next(runtime)
            send(@status.last[:next_action], runtime)
          end
          
          def start_work(runtime)
            @status << {:desc => 'working on', :next_action => 'complete', :at => Time.now, :color => :red}
          end
          
          def complete(runtime)
            @status << {:desc => 'completed', :next_action => 'delete', :at => Time.now, :color => :gray}
          end
          
          def delete(runtime)
            runtime[:todo].delete(self)
          end
          
          def to_s
            st = @status.last
            send(st[:color] || :normal, "#{st[:next_action].titleize}: #{@detail}")
          end
          
          def normal(msg)
            "\e[#{FONT_STYLES[:bold]};#{COLORS[:yellow]}m#{msg}\e[0m"
          end
          
          def red(msg)
            "\e[#{FONT_STYLES[:bold]};#{COLORS[:red]}m#{msg}\e[0m"
          end

          def gray(msg)
            "\e[#{FONT_STYLES[:normal]};#{COLORS[:gray]}m#{msg}\e[0m"
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