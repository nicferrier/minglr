require 'test_helper'

class AttachmentTest < Test::Unit::TestCase
  
  context AttachmentTest do
    
    context "configure" do
      
      should "append to the site url" do
        options = { :protocol => "proto",
                    :username => "user",
                    :password => "pass",
                    :host_and_port => "somehost.com:1234",
                    :project => "my_project"}
        MingleResource.configure(options)
        Attachment.configure
        assert_equal  "/projects/my_project/cards/1/", Attachment.prefix(:card_number => 1)
      end
      
    end
    
  end

end
