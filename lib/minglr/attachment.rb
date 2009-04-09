class Attachment < MingleResource
  
  def self.configure
    self.prefix += "cards/:card_number/"
  end
  
end
