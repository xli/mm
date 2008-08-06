module MM
  module Console
    class RuntimeVariable
      def initialize(variable)
        @name = variable[:name]
        @value = variable[:value]
      end
      
      def execute(runtime)
        if @value.blank?
          runtime.delete @name.to_sym
        else
          runtime[@name.to_sym] = @value
        end
      end
    end
  end
end
