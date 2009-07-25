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
    
    end

  end
  
end