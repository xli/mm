module MM
  module Command
    class Help
      def doc
%{
mm, version #{MM::VERSION}

Queck start part 1:

MM is a tool for integrating Mingle(http://studios.thoughtworks.com/) with command-line
For additional information, see http://mm.rubyforge.org
Notes: 
  * There would be a '.mm_pstore' file created for cache in the mm working directory.
}
      end
    end
  end
end
