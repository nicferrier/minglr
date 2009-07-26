module Resources
  
  class Attachment < Base
  
    def self.configure
      self.prefix += "cards/:card_number/"
    end
    
    def self.fetch(card_number, username, password)
      if card_to_update = Card.find(card_number)
        attachments = find(:all, :params => { :card_number => card_number })
        attachments.each do |attachment|
          url = self.site + attachment.url
          url.userinfo = nil, nil
          puts "Downloading #{url.to_s}:"
          `curl --insecure --progress-bar --output #{attachment.file_name} --user #{username}:#{password} #{url}`
        end
      end
    end
  
  end
  
end