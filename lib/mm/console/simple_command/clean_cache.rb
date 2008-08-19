module MM
  module Console
    module SimpleCommand
      class CleanCache
        include Base

        def self.keys
          ['clean_cache']
        end

        def self.doc(runtime)
          names = runtime[:api].instance_variable_names.collect{|n| n.gsub(/@/, '').titleize} - ['Runtime']
          "clean current cached resource objects: #{names.empty? ? '(no object cached)' : names.join(", ")}"
        end
      
        def execute(runtime)
          runtime[:api] = runtime[:api].renew
        end
      end
    end
  end
end