require 'test_helper'

module Resources
  
  class UserTest < Test::Unit::TestCase
  
    context User do
    
      context "print_all" do
        
        should "should warn if there are no users" do
          User.expects(:find).with(:all).returns([])
          User.expects(:warn).with("No users in project")
          User.print_all
        end
        
        should "print the users found with format" do
          user1 = stub("UserXml", :user => stub("User", :login => "user1", :name => "User One", :email => "user1@test"))
          user2 = stub("UserXml", :user => stub("User", :login => "user22", :name => "User TwoTwo", :email => "user22@test"))
          User.expects(:find).with(:all).returns([user1, user2])
          User.expects(:puts).with(" user1 -    User One -  user1@test")
          User.expects(:puts).with("user22 - User TwoTwo - user22@test")
          User.print_all
        end
      
      end
      
      context "find_user_id_for_user" do
        
        should_eventually "return the owner_id of the user matching the username" do
        end
        
      end
    
    end

  end
  
end