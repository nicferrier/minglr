require 'test_helper'

module Minglr
  
  class ActionTest < Test::Unit::TestCase
  
    context Action do
    
      context "valid_actions" do
        
        should "return an array of valid actions" do
          valid_actions = ["users", "cards", "card", "move", "update", "attach", "projects", "create", "fetch"].sort
          assert_equal [], (valid_actions - Action.valid_actions)
          #assert_equal valid_actions, Action.valid_actions.sort
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
        
        should "ignore the first option if no project is specified" do
          action = :someaction
          options = ["someaction", "option2"]
          flag_options = { :foo => "bar" }
          config = { :foo => "bar" }
          
          Minglr::Action::Commands.expects(:send).with(action, ["option2"], flag_options, config)
          Action.execute(action, options, flag_options, config)
        end
        
        should "ignore the first two options if project is specified" do
          action = :someaction
          options = ["someproject", "someaction", "option2"]
          flag_options = { :foo => "bar" }
          config = { :foo => "bar" }
          
          Minglr::Action::Commands.expects(:send).with(action, ["option2"], flag_options, config)
          Action.execute(action, options, flag_options, config)          
        end
        
        should "send the action to commands" do
          action = "someaction"
          options = ["option1", "option2"]
          flag_options = { :foo => "bar" }
          config = { :foo => "bar" }
          
          Minglr::Action::Commands.expects(:send).with(action, options, flag_options, config)
          Action.execute(action, options, flag_options, config)
        end
        
        should "rescue and print an error if the resource can't be found" do
          Action.expects(:puts).with("Failed with MyError for URL #{Resources::Base.site}...")
          Minglr::Action::Commands.expects(:send).raises(ActiveResource::ResourceNotFound, stub("Response", :code => "MyError"))
          
          Action.execute("someaction", ["someaction"])
        end
        
      end
       
    end
  
  end
  
end