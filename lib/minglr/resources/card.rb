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
      if card = find(card_number)
        puts card.to_s(status_property)
      else
        warn "No card ##{card_number} found"
      end
    end
    
    def self.create(options = {}, status_property = nil)
      options.merge!{status_property.to_sym => "New"} if status_property
      card = self.new(options)
      if card.save
        card.reload
        puts "Card #{card.number} created"
      else
        warn "Unable to create card"
      end
    end
    
    def self.update(card_number, options = {})
      if card_to_update = find(card_number)
        options.each do |attribute, value|
          card_to_update.send("#{attribute.to_s}=".to_sym, value)
        end
        card_to_update.save
        puts "Card #{card_to_update.number} updated\n\n"
        puts card.to_s
      else
        warn "Unable to update card #{card_number}"
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
