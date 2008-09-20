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
        returning Resource::Mingle::TransitionExecution.create(attrs) do |te|
          unless te.errors.empty?
            raise te.errors.full_messages.join("; ")
          end
        end
      end
    end
  end
end
