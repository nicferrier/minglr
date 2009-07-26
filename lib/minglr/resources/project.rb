module Resources
  
  class Project < Base
    
    def self.configure
      self.prefix = self.prefix.split("/")[0...-1].join("/")
      self.site = self.prefix
    end
    
  end
  
end
