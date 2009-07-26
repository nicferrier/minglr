require "uri"

module Resources
  
  class Base < ActiveResource::Base
    
    class << self
      
      def configure(uri_options)
        uri = URI.parse(uri_options[:url])
        uri.user = uri_options[:username]
        uri.password = uri_options[:password]
        self.site = uri
      end

      def print_collection(collection, attributes, align = :left)
        output = []
        longest_attributes = Array.new(attributes.length, 0)
        alignment = (align == :left ? :ljust : :rjust)
        collection.each do |element|
          entry = []
          attributes.each_with_index do |attribute, index|
            attribute_value = element.send(attribute).to_s
            longest_attributes[index] = attribute_value.length if attribute_value.length > longest_attributes[index]
            entry << attribute_value
          end
          output << entry
        end
        output.each do |entry|
          row = []
          entry.each_with_index do |part, index|
            row << [part.send(alignment, longest_attributes[index])]
          end
          puts row.join(" - ")
        end
      end
      
      def warn(message)
        puts "Warning: #{message}"
      end
      
    end
  
  end
  
end
