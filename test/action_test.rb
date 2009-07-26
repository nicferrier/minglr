require 'test_helper'

module Minglr
  
  class ActionTest < Test::Unit::TestCase
  
    context Action do
    
      context "valid_actions" do
        
        should "return an array of valid actions" do
          valid_actions = ["users", "cards", "card", "move", "update", "attach", "projects", "create", "fetch"].sort
          assert_equal valid_actions, Action.valid_actions.sort
        end
      
      end
      
      context "valid_action?" do
        
        should "return true if action is a valid action" do
          assert_equal true, Action.valid_action?("move")
        end
        
        should "return false if action is not a valid action" do
          assert_equal false, Action.valid_action?("frobble")
        end
        
      end
      
      context "execute" do
        
        should_eventually "ignore the first option if no project is specified" do
        end
        
        should_eventually "ignore the first two options if project is specified" do
        end
        
        should_eventually "send the action to commands" do
        end
        
        should_eventually "rescue and print an error if the resource can't be found" do
        end
        
      end
    
    end
  
  end
  
end