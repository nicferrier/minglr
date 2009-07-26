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
        
        should_eventually "download all found attachments for a given card number" do
        end
      
      end
      
      context "attach" do
        
        should_eventually "upload file for a given card number" do
        end
      
      end
    
    end

  end
  
end