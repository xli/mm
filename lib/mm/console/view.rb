module MM
  module Console
    class View
      
      class Context
        include SimpleHashable
        
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
        
        def open(runtime)
          ret = runtime[:api].execute_cmd("open #{File.join(runtime[:site], "cards?view=#{@view_name}").inspect}")
          ret.first == 0 ? nil : ret.last
        end
        
        def to_s
          @view_name.to_s
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