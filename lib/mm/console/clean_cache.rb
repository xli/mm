module MM
  module Console
    class CleanCache
      def execute(runtime)
        runtime[:api] = runtime[:api].renew
      end
    end
  end
end