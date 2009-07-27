require 'test_helper'

module Resources
  
  class CardTest < Test::Unit::TestCase
  
    context Card do

      context "create" do
        
        should "create a card with options passed in" do
          card = Card.new
          card.stubs(:number).returns(1)
          Card.expects(:new).with(:name => "Name").returns(card)
          Card.any_instance.expects(:save).returns(true)
          Card.any_instance.expects(:reload)
          Card.expects(:puts).with("Card #1 created")
          Card.create({:name => "Name"})
        end
        
        should "create a card with the status of new if status property is available" do
          card = Card.new
          card.stubs(:number).returns(1)
          Card.expects(:new).with(:some_option => "value", :cp_status => "New").returns(card)
          Card.any_instance.expects(:save).returns(true)
          Card.any_instance.expects(:reload)
          Card.expects(:puts).with("Card #1 created")
          Card.create({:some_option => "value"}, "cp_status")
        end
        
        should "warn if it is unable to create the card" do
          Card.any_instance.expects(:save).returns(false)
          Card.expects(:warn).with("Unable to create card")
          Card.create
        end
        
      end
      
      context "move" do
        
        should "move card from one state to the next as defined" do
          card = Card.new
          card.stubs(:card_type_name).returns("story")
          card.stubs(:status).returns("New")
          config = { :story_state_1 => "New > Dev", :status_property => "status"}
          response = stub("Response", :attributes => { "status" => "completed" })
          
          Card.expects(:find).with(1).returns(card)
          TransitionExecution.expects(:create).with(:transition => 'Dev', :card => 1).returns(response)
          Card.expects(:puts).with("Moved card from New to Dev")
          Card.move(1, {}, config)
        end
        
        should "warn if no matching card type is found" do
          card = Card.new
          card.stubs(:card_type_name).returns("someothertype")
          card.stubs(:status).returns("New")
          config = { :story_state_1 => "New > Dev", :status_property => "status"}
          
          Card.expects(:find).with(1).returns(card)
          Card.expects(:warn).with("No transitions defined for card of type someothertype")
          Card.move(1, {}, config)
        end
        
        should "warn if card has no status property" do
          card = Card.new
          card.stubs(:card_type_name).returns("story")
          card.stubs(:current_status).returns("New")
          config = { :story_state_1 => "New > Dev"}
          
          Card.expects(:find).with(1).returns(card)
          Card.expects(:warn).with("No known status of card #1, cannot move!")
          Card.move(1, {}, config)
        end
        
        should "warn if card cannot be found" do
          Card.expects(:find).with(0).returns(nil)
          Card.expects(:warn).with("No card #0 found to move")
          Card.move(0)
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
        
        should "print the details for a given card" do
          status_property = "cp_status"
          card = Card.new
          card.expects(:to_s).with(status_property)
          Card.expects(:find).with(1).returns(card)
          Card.stubs(:puts)
          Card.print_card(1, status_property)
        end
        
        should "warn if it is not able to find the card" do
          Card.expects(:find).with(0).returns(nil)
          Card.expects(:warn).with("No card #0 found")
          Card.print_card(0)
        end
        
      end
      
      context "update" do
        
        should "update a card with the options passed in" do
          card = mock("Card")
          card.stubs(:number).returns(1)
          card.expects(:foo=).with("bar")
          card.expects(:baz=).with("frobble")
          card.expects(:save)
          Card.stubs(:puts)
          Card.expects(:find).with(1).returns(card)
          
          Card.update(1, {:foo => "bar", :baz => "frobble"})
        end
        
        should "print out the details of the card after updating" do
          card = mock("Card")
          card.stubs(:number).returns(1)
          card.stubs(:foo=)
          card.stubs(:baz=)
          card.stubs(:save)
          Card.stubs(:find).with(1).returns(card)
          
          Card.expects(:puts).with("Card #1 updated\n\n")
          Card.expects(:puts).with(card.to_s)          
          Card.update(1, {:foo => "bar", :baz => "frobble"})
        end
        
        should "warn if it is not able to find the card" do
          Card.expects(:find).with(0).returns(nil)
          Card.expects(:warn).with("Unable to update card #0")
          Card.update(0)
        end
        
      end
      
      context "to_s" do
        
        should "format the details of a given card including attachments" do
          Resources::Base.site = "http://foo.bar"
          
          attachment = Attachment.new
          attachment.stubs(:file_name).returns("My File Name")
          attachment.stubs(:url).returns("http://some.url")
          Attachment.expects(:find).with(:all, :params => { :card_number => 1 }).returns([attachment])
          
          card = Card.new
          card.stubs(:number).returns(1)
          card.stubs(:name).returns("My Name")
          card.stubs(:card_type_name).returns("My Type")
          card.stubs(:description).returns("My Description")
          
          expected_output = <<-EOS
     Number: 1
       Name: My Name
       Type: My Type
     Status: 
Description: My Description

Attachments:
  * My File Name: http://some.url
          EOS
          assert_equal expected_output, card.to_s
        end
        
      end
    
    end

  end
  
end