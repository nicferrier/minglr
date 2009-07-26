module Resources
  
  class Project < Base
    
    def self.configure
      self.prefix = self.prefix.split("/")[0...-1].join("/")
      self.site = self.prefix
    end
    
    def self.print_all(options = [], status_property = nil)
      attributes = [:name, :description]
      projects = find(:all)
      projects.send(:extend, Minglr::Extensions::Array)
      projects = projects.filter(attributes, options)
      
      if projects.any?
        print_collection projects, attributes
      else
        warn "No projects found"
      end
    end
    
  end
  
end
