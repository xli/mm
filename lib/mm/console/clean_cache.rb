module MM
  module Console
    class CleanCache
      def execute(runtime)
        runtime[:api] = runtime[:api].renew
      end
      
      def doc(runtime)
        names = runtime[:api].instance_variable_names.collect(&:titleize)
        "clean current cached resource objects: #{names.empty? ? '(no object cached)' : names.join(", ")}"
      end
    end
    Processor.register(:key => 'clean_cache', :instance => CleanCache.new)
  end
end