module Resources
  
  class PropertyDefinition < Base
    
    def self.project_options
      properties = find(:all, :from => '/api/v2/projects/scrum_demo/property_definitions.xml')
      properties.collect { |property| [property.column_name.to_sym, property.name] }
    end
    
  end
  
end
