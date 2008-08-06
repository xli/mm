module MM
  module Console
    class Tabs
      def execute(runtime)
        if @tabs = runtime[:api].favorites.select{|f|f.tab_view}
          runtime[:selecting_list] = SelectingList.new(@tabs.collect(&:name), MM::Console::View)
        end
      end
      
      def doc(runtime)
        "show tabs in your Mingle project"
      end
    end
    
    Processor.register(:key => 'tabs', :short_key => 't', :instance => Tabs.new)
  end
end
