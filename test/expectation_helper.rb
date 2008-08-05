require 'rubygems'
require 'expectations'

$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'mm'

module MM
  module Test
    class Stub

      def []=(*argv)
        key, value = argv[0..-2], argv.last
        method_stubs[key.inspect] = value
      end
      
      def method_stubs
        @stubs ||= {}
      end
  
      def method_missing(method, *argv)
        key = [method, *argv]
        method_stubs[key.inspect]
      end
    end

    class Helper
      def runtime
        {:api => Stub.new}
      end
    
      def card(attrs)
        MM::Resource::Mingle::Card.site = 'test'
        MM::Resource::Mingle::Card.new(attrs)
      end
      
      def property_definition(attrs)
        MM::Resource::Mingle::PropertyDefinition.site = 'test'
        MM::Resource::Mingle::PropertyDefinition.new(attrs)
      end
      
      def favorite(attrs)
        MM::Resource::Mingle::Favorite.site = 'test'
        MM::Resource::Mingle::Favorite.new(attrs)
      end
    end
  end
end

$helper = MM::Test::Helper.new

