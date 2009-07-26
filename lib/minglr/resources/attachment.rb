require 'httpclient'

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
    
    def self.attach(card_number, file_name, username, password)
      if card_to_update = Card.find(card_number)
        url = (site.to_s.gsub(/#{site.path}$/, '')) + collection_path(:card_number => card_number)
        if File.exist?(file_name)
          File.open(file_name) do |file|
            body = { 'file' => file, "filename" => file_name }
            client = HTTPClient.new
            client.set_auth(nil, username, password)
            response = client.post(url, body)
            if response.status_code == 201
              puts "File '#{file_name}' attached to card #{card_number}"
            else
              puts "Error attaching file '#{file_name}' to card #{card_number} (Got back HTTP code #{response.status_code})"
            end
          end
        else
          warn "Unable to open file '#{file_name}'"
        end
      end
    end
  
  end
  
end