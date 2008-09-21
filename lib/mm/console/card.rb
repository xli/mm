module MM
  module Console
    class Card
      
      class Context
        include SimpleHashable

        def initialize(card)
          @card = card
        end
        
        def push(tokens)
          tokens.push [:CARD_RESOURCE, @card]
        end
        
        def apply(runtime)
          runtime[:context] = self
          @card
        end
        
        def open(runtime)
          ret = runtime[:api].execute_cmd("open #{File.join(runtime[:site], 'cards', @card.number.to_s).inspect}")
          ret.first == 0 ? nil : ret.last
        end
        
        #don't use Delegator, which has problem with store this object instance as yaml
        def method_missing(method, *args, &block)
          if @card.respond_to?(method)
            @card.send(method, *args, &block)
          else
            super
          end
        end
        
        def to_s
          "#{@card.card_type_name} #{@card.number}"
        end
      end
      
      attr_reader :number
      
      def initialize(number, attrs=nil)
        @number = number.is_a?(String) ? number.to_i : number
        @attrs = attrs
      end
      
      def execute(runtime)
        if card = @number.kind_of?(ActiveResource::Base) ? @number : runtime[:api].find_card_by_number(@number)
          Context.new(card).apply(runtime)
          if @attrs.blank?
            card
          elsif @attrs.size == 1
            MM::Console::CardResourceCommand.new(@attrs.first, card).execute(runtime)
          else
            @attrs.inject({}) do |map, att|
              map[att.to_sym] = MM::Console::CardResourceCommand.new(att, card).execute(runtime)
              map
            end
          end
        else
          raise "Couldn't find card by number #{@number}"
        end
      end
    end
  end
end
