module Resources
  
  class User < Base
    
    def self.print_all(options = [])
      attributes = [:login, :name, :email]
      users = find(:all).collect! { |user| user.user }
      users.send(:extend, Minglr::Extensions::Array)
      users = users.filter(attributes, options)
      if users.any?
        print_collection users, attributes, :right
      else
        warn "No users in project"
      end
    end
    
    def self.find_user_id_for_user(user)
      if user = Resources::User.find(:all).select { |user| user.user.login == user }.first
        user.user_id
      end
    end
    
  end
  
end
