require 'mm/api/mingle'

module MM
  class API
    include Mingle
    
    def initialize(runtime)
      @runtime = runtime
    end
    
    def to_s
      Mingle.instance_methods.join("\n")
    end
  end
end
