require 'mm/api/mingle'

module MM
  class API
    include Mingle
    
    def initialize(runtime={})
      @runtime = runtime
    end
    
    def execute_cmd(cmd)
      output = %x[#{cmd}]
      [$?.exitstatus, output]
    end

    def init(klass)
      klass.site = @runtime[:site]
    end
    
    def renew
      self.class.new(@runtime)
    end

    def to_s
      Mingle.instance_methods.join("\n")
    end
  end
end
