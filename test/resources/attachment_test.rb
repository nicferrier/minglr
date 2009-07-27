require 'test_helper'

module Resources
  
  class AttachmentTest < Test::Unit::TestCase
  
    context Attachment do

      context "configure" do
        
        should "append to the site url" do
          options = { :username => "user",
                      :password => "pass",
                      :url => "proto://somehost.com:1234/projects/my_project" }
          Base.configure(options)
          Attachment.configure
          assert_equal  "/projects/my_project/cards/1/", Attachment.prefix(:card_number => 1)
        end
      
      end
      
      context "fetch" do
        
        should "download all found attachments for a given card number" do
          card = Card.new
          card.stubs(:number).returns(1)
          
          attachment1 = Attachment.new
          attachment1.stubs(:url).returns("http://attachment1.url")
          attachment1.stubs(:file_name).returns("attachment1.txt")
          attachment2 = Attachment.new
          attachment2.stubs(:url).returns("http://attachment2.url")
          attachment2.stubs(:file_name).returns("attachment2.txt")

          Attachment.stubs(:puts)
          Card.expects(:find).with(1).returns(card)
          Attachment.expects(:find).with(:all, :params => { :card_number => 1 }).returns([attachment1, attachment2])
          Attachment.expects(:curl).with("curl --insecure --progress-bar --output attachment1.txt --user username:password http://attachment1.url")
          Attachment.expects(:curl).with("curl --insecure --progress-bar --output attachment2.txt --user username:password http://attachment2.url")
          
          Attachment.fetch(1, "username", "password")
        end
      
      end
      
      context "attach" do
        
        setup do
          options = { :username => "user",
                      :password => "pass",
                      :url => "proto://somehost.com:1234/projects/my_project" }
          Base.configure(options)
        end
        
        should "upload file for a given card number" do
          file_name = File.join(File.dirname(__FILE__), "..", "..", "Rakefile")
          
          card = Card.new
          card.stubs(:number).returns(1)
          
          fake_response = stub("Response", :status_code => 201)
          fake_client = mock("HTTPClient")
          fake_client.expects(:post).returns(fake_response)
          fake_client.expects(:set_auth).with(nil, "username", "password")
          
          Card.expects(:find).with(1).returns(card)
          HTTPClient.expects(:new).returns(fake_client)
          Attachment.expects(:puts).with("File '#{file_name}' attached to card 1")

          Attachment.attach(1, file_name, "username", "password")
        end
        
        should "warn for invalid file" do          
          card = Card.new
          card.stubs(:number).returns(1)
          
          Card.expects(:find).with(1).returns(card)
          File.expects(:exist?).with("myfile.txt").returns(false)
          Attachment.expects(:warn).with("Unable to open file 'myfile.txt'")
          
          Attachment.attach(1, "myfile.txt", "username", "password")
        end
      
      end
    
    end

  end
  
end