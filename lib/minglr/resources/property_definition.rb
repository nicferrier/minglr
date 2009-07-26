module Resources
  
  class PropertyDefinition < Base
    
    def self.project_options
      properties = find(:all)
      properties.collect { |property| [property.column_name.to_sym, property.name] }
    end
    
  end
  
end
