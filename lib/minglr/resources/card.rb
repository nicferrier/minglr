module Resources
  
  class Card < Base
    
    def self.print_all(options = {})
      attributes = [:number, :card_type_name, options.delete(:status_property), :name].compact
      cards = Resources::Card.find(:all)
      cards.send(:extend, Minglr::Extensions::Array)
      cards = cards.filter(attributes, options)
      if cards.any?
        print_collection(cards, attributes)
      else
        warn "No cards found"
      end
    end
    
  end
  
end
