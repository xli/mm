module MM
  module Console
    module SimpleCommand
      class Tabs
        include Base
        def self.keys
          ['tabs', 't']
        end
        def self.doc(runtime)
          "show tabs in your Mingle project"
        end

        def execute(runtime)
          if @tabs = runtime[:api].favorites.select{|f|f.tab_view}
            runtime[:list] = SelectingList.new(@tabs.collect(&:name), MM::Console::View)
          end
        end
      end
    end
  end
end
