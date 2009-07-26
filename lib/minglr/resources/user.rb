module Resources
  
  class User < Base
    
    def self.collection(options = {})
      attributes = [:login, :name, :email]
      users = find(:all).collect! { |user| user.user }
      users.send(:extend, Minglr::Extensions::Array)
      users = users.filter(attributes, options)
      if users.any?
        print_collection users, attributes, :right
      else
        puts "No users in project"
      end
    end
    
  end
  
end
