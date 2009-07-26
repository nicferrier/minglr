module Minglr
  
  module Extensions
    
    module Array
      
      def filter(attributes, words)
        collection = self
        words.each do |word|
          collection = self.select do |element|
            output = ""
            attributes.each { |attribute| output << element.send(attribute).to_s + " " }
            output =~ /#{word}/i
          end
        end
        collection
      end
    
    end
  
  end
  
end