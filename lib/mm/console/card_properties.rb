module MM
  module Console
    class CardProperties
      def execute(runtime)
        if @tabs = runtime[:api].favorites.select{|f|f.tab_view}
          runtime[:list] = SelectingList.new(@tabs.collect(&:name), MM::Console::View)
        end
      end
    end
  end
end