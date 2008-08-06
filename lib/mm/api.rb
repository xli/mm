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
      raise "Please setup a variable name site for your project. \n - Example: site = 'http://login:password@mingle.domain.com/projects/project_identifier'" if @runtime[:site].blank?
      
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
