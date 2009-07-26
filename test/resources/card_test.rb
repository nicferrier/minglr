require 'test_helper'

module Resources
  
  class CardTest < Test::Unit::TestCase
  
    context Card do
    
      context "print_all" do
        
        should "should warn if there are no cards" do
          Card.expects(:find).with(:all).returns([])
          Card.expects(:warn).with("No cards found")
          Card.print_all
        end
        
        should "print the cards found with format" do
          card1 = stub("Card", :number => 1, :card_type_name => "Story", :name => "Some Story")
          card2 = stub("Card", :number => 2, :card_type_name => "Task", :name => "Some Task")
          Card.expects(:find).with(:all).returns([card1, card2])
          Card.expects(:puts).with("1 - Story - Some Story")
          Card.expects(:puts).with("2 - Task  - Some Task ")
          Card.print_all
        end
        
        should "print cards with status property if available" do
          card1 = stub("Card", :number => 1, :card_type_name => "Story", :name => "Some Story", :cp_status => "Ready")
          Card.expects(:find).with(:all).returns([card1])
          Card.expects(:puts).with("1 - Story - Ready - Some Story")
          Card.print_all({:status_property => "cp_status"})
        end
      
      end
    
    end

  end
  
end