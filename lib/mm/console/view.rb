module MM
  module Console
    class View
      
      class Context
        def initialize(view_name, cards)
          @view_name = view_name
          @cards = cards
        end
        
        def push(tokens)
          tokens.push [:VIEW_RESOURCE, @view_name]
        end
        
        def apply(runtime)
          runtime[:context] = self
          runtime[:list] = SelectingList.new(@cards, MM::Console::Card)
        end
        
        def to_s
          "#{@view_name}"
        end
      end
      
      def initialize(view_name)
        @view_name = view_name
      end
      
      def execute(runtime)
        if @cards = runtime[:api].find_cards(:view => @view_name)
          Context.new(@view_name, @cards).apply(runtime)
        end
      end
    end
  end
end