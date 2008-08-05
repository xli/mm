begin
  require 'active_resource'
rescue LoadError
  require 'rubygems'
  require 'active_resource'
end

require 'mm/resource/mingle'