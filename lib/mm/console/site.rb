module MM
  module Console
    class Site
      def initialize(site=nil)
        @site = site ||= ask_for_site
      end
      
      def to_s
        @site.gsub(/:[^@:]*@/, ":***@")
      end
      
      private
      def ask_for_site
        puts  "? > What's your Mingle project url?"
        puts  "      Example: http://my_login:password@mingle.mycompany.com/projects/project_identifier"
        print "? >"
        input = readline.strip
        # @runtime[:site] = ::MM::Console::Site.new(input)
        input
      end
    end
  end
end