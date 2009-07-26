module Resources
  
  class Card < Base
    
    def self.print_all(options = [], status_property = nil)
      attributes = [:number, :card_type_name, status_property, :name].compact
      cards = Resources::Card.find(:all)
      cards.send(:extend, Minglr::Extensions::Array)
      cards = cards.filter(attributes, options)
      if cards.any?
        print_collection(cards, attributes)
      else
        warn "No cards found"
      end
    end
    
    def self.print_card(card_number, status_property = nil)
      attributes = [:number, :card_type_name, status_property, :name, :description].compact
      if card = Resources::Card.find(card_number)
        puts card.to_s(status_property)
      else
        warn "No card ##{card_number} found"
      end
    end
    
    def to_s(status_property = nil)
      attachments = Resources::Attachment.find(:all, :params => { :card_number => number })
      attachments = attachments.collect do |attachment|
        "* #{attachment.file_name}: #{Resources::Base.site + attachment.url}"
      end
      output = <<-EOS
     Number: #{number}
       Name: #{name}
       Type: #{card_type_name}
     Status: #{send(status_property) if status_property}
Description: #{description}

Attachments:
  #{attachments.join("\n")}
    EOS
      output
    end
    
  end
end
