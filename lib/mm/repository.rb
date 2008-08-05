# Copyright (c) 2008 Li Xiao
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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