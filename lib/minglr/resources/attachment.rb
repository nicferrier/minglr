module Resource
  
  class Attachment < Base
  
    def self.configure
      self.prefix += "cards/:card_number/"
    end
  
  end
  
end