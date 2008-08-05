module MM
  module Console
    class Tabs
      def execute(runtime)
        if @tabs = runtime[:api].favorites.select{|f|f.tab_view}
          runtime[:selecting_list] = MM::Console::SelectingList.new(@tabs.collect(&:name), MM::Console::View)
        end
      end
    end
  end
end