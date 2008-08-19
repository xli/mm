module MM
  module Console
    module SimpleCommand
      class ToDo
        
        class Event
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
          if @todo.blank?
            runtime[:todo] ||= SelectingList.new([], Event)
          end
        end
      end
    end
  end
end