module Resources
  
  class Card < Base
    
    def self.create(options = {}, status_property = nil)
      options.merge!({status_property.to_sym => "New"}) if status_property
      card = self.new(options)
      if card.save
        card.reload
        puts "Card #{card.number} created"
      else
        warn "Unable to create card"
      end
    end
    
    def self.move(card_number, options = {}, config = {})
      if card_to_move = find(card_number)
        transition_options = { :card => card_number }
        transition_options.merge!({ :comment => options[:comment]}) if options[:comment]
        current_status = card_to_move.send(config[:status_property]) if config[:status_property]
        next_transition = nil
        
        card_type = card_to_move.card_type_name.downcase
        case card_type
        when /defect/
          status_states = config.select do |key, value|
            key.to_s =~ /^defect/
          end
        when /task/
          status_states = config.select do |key, value|
            key.to_s =~ /^task_state_/
          end
        when /story/
          status_states = config.select do |key, value|
            key.to_s =~ /^story_state/
          end
        else
          puts "No transitions defined for card of type #{card_to_move.card_type_name}"  
        end
        status_states = status_states.collect {|state| state.last }.collect {|state| state.split(">").collect { |value| value.strip } }
        next_transition = status_states.select {|state| state.first.downcase == current_status.downcase }.first.last
        transition_options.merge!({ :transition => next_transition })

        if response = TransitionExecution.create(transition_options)
          if response.attributes["status"] == "completed"
            puts "Moved card from #{current_status} to #{next_transition}"
          end
        end
      else
        warn "No card #{card_number} found to move"
      end
    end
    
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
