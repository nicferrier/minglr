module Resources
  
  class Base < ActiveResource::Base
    
    def self.configure(uri_options)
      self.site = "#{uri_options[:protocol]}://#{uri_options[:username]}:#{uri_options[:password]}@#{uri_options[:host_and_port]}/projects/#{uri_options[:project]}"
    end
    
  end
  
end
