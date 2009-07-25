require "uri"

module Resources
  
  class Base < ActiveResource::Base
    
    def self.configure(uri_options)
      uri = URI.parse(uri_options[:url])
      uri.user = uri_options[:username]
      uri.password = uri_options[:password]
      self.site = uri
    end
    
  end
  
end
