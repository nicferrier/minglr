 module Minglr
  
  class Action
  
    def self.execute(action, options = [], flag_options = {}, config = {})
      if action.to_s == options[0]
        options.shift
      else
        options.shift
        options.shift
      end
      begin
        Commands.send(action, options, flag_options, config)
      rescue ActiveResource::ResourceNotFound => error
        puts error.message + " for URL '#{Resources::Base.site}' ..."
      end
    end
  
    def self.valid_actions
      Commands.methods(false)
    end
  
    def self.valid_action?(action)
      valid_actions.include? action
    end
  
    class Commands
    
      def self.attach(options, flag_options, config)
        raise "Missing card number!" if options.empty?
        
        card_number = options.first
        file_name = flag_options[:file_attachment]
        Resources::Attachment.attach(card_number, file_name, config[:username], config[:password])
      end

      def self.card(options, flag_options, config)
        raise "Missing card number!" if options.empty?
        
        card_number = options.first
        Resources::Card.print_card(card_number, config[:status_property])
      end
  
      def self.cards(options, flag_options, config)
        Resources::Card.print_all(options, config[:status_property])
      end
  
      def self.create(options, flag_options, config)
        Resources::Card.create(flag_options, config[:status_property])
      end
  
      def self.fetch(options, flag_options, config)
        raise "Missing card number!" if options.empty?
        
        card_number = options.first
        Resources::Attachment.fetch(card_number, config[:username], config[:password])
      end
  
      def self.move(options, flag_options, config)
        raise "Missing card number!" if options.empty?
        
        card_number = options.first
        Resources::Card.move(card_number, flag_options, config)
      end
  
      def self.projects(options, flag_options, config)
        Resources::Project.print_all(options, config[:status_property])
      end
  
      def self.update(options, flag_options, config)
        raise "Missing card number!" if options.empty?
        
        card_number = options.first
        Resources::Card.update(card_number, flag_options)
      end
  
      def self.users(options, flag_options, config)
        Resources::User.print_all(options)
      end
    
    end
    
  end
  
end