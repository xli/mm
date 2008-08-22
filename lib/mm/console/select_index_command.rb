module MM
  module Console
    class SelectIndexCommand
      def initialize(index)
        @index = index
      end
      
      def execute(runtime)
        runtime[:list].select_by_index(runtime, @index)
      end
    end
  end
end