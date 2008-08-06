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
        
        def to_s
          "#{@view_name}"
        end
      end
      
      def initialize(view_name)
        @view_name = view_name
      end
      
      def execute(runtime)
        if @cards = runtime[:api].find_cards(:view => @view_name)
          runtime[:context] = Context.new(@view_name, @cards)
          runtime[:selecting_list] = SelectingList.new(@cards, MM::Console::Card)
        end
      end
    end
  end
end