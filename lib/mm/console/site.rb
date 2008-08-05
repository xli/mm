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
        puts  "      Example: http://login:password@mingle.company.com/projects/project_identifier"
        print "? >"
      end
    end
  end
end