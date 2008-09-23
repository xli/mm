module MM
  class API
    module Mingle
      def team_members
        return @team_members if defined?(@team_members)
        init(Resource::Mingle::User)
        @team_members = Resource::Mingle::User.find(:all)
      end
  
      def property_definitions
        return @property_definitions if defined?(@property_definitions)
        init(Resource::Mingle::PropertyDefinition)
        @property_definitions = Resource::Mingle::PropertyDefinition.find(:all)
      end
  
      def favorites
        return @favorites if defined?(@favorites)
        init(Resource::Mingle::Favorite)
        @favorites = Resource::Mingle::Favorite.find(:all)
      end
    
      def find_card(options={})
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(:first, options)
      end
    
      def find_card_by_number(number)
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(number)
      end
    
      def find_cards(options={})
        init(Resource::Mingle::Card)
        Resource::Mingle::Card.find(:all, :params => options)
      end

      def create_transition_execution(attrs)
        init(Resource::Mingle::TransitionExecution)
        te = Resource::Mingle::TransitionExecution.create(attrs)
        unless te.errors.empty?
          raise te.errors.full_messages.join("; ")
        end
      end
      
      #return transition names array, e.g. ['fix', 'close']
      def card_transitions(card)
        require 'net/http'
        require 'net/https'

        uri = URI.parse(File.join(@runtime[:site], 'cards', card.number.to_s))
        returning [] do |transition_names|
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
          http.start do
            req = Net::HTTP::Get.new(uri.request_uri)
            req.basic_auth *uri.userinfo.split(':')
            response = http.request(req)
            r = /<span style='padding-left:0.5em;text-decoration:underline'>([^<]+)<\/span>/
            doc = response.body
            while m = doc.match(r)
              doc = doc[m.offset(0).last..-1]
              transition_names << m.captures
              break if doc.nil?
            end
          end
          transition_names.uniq!
          transition_names.flatten!
        end
      end
    end
  end
end
