require 'pstore'
module MM
  module Repository
    
    def self.destroy
      File.delete(file_name) if File.exist?(file_name)
    end

    def [](key)
      return nil unless File.exist?(self.class.file_name)
      
      repository = PStore.new(self.class.file_name)
      repository.transaction(true) do
        repository[key]
      end
    end

    def []=(key, value)
      repository = PStore.new(self.class.file_name)
      repository.transaction do
        repository[key] = value
      end
    end
  end

  class RuntimeRepository
    def self.file_name
      '.mm_pstore'
    end
    
    def self.load
      self.new['runtime'] || {}
    end
    
    def self.save(runtime)
      self.new['runtime'] = runtime
    end
    
    include Repository
  end
end