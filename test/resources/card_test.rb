require 'test_helper'

module Resources
  
  class CardTest < Test::Unit::TestCase
  
    context Card do
      
      context "create" do
        
        should_eventually "create a card with options passed in" do
        end
        
        should_eventually "create a card with the status of new if status property is available" do
        end
        
        should_eventually "warn if it is unable to create the card" do
        end
        
      end
      
      context "move" do
        
        should "move card from one state to the next as defined" do
        end
        
        should "warn if card cannot be found" do
        end
        
      end
      
      context "print_all" do
        
        should "warn if there are no cards" do
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
          Card.print_all([], "cp_status")
        end
      
      end
      
      context "print_card" do
        
        should_eventually "print the details for a given card" do
        end
        
      end
      
      context "update" do
        
        should_eventually "update a card with the options passed in" do
        end
        
        should_eventually "print out the details of the card after updating" do
        end
        
        should_eventually "warn if it is not able to find the card" do
        end
        
      end
      
      context "to_s" do
        
        should_eventually "format the details of a given card including attachments" do
        end
        
      end
    
    end

  end
  
end