require 'test_helper'

class MinglrResourceTest < Test::Unit::TestCase
  
  context MinglrResourceTest do
    
    context "configure" do
      
      should "combine options to build url" do
        options = { :protocol => "proto",
                    :username => "user",
                    :password => "pass",
                    :host_and_port => "somehost.com:1234",
                    :project => "my_project"}
        MingleResource.configure(options)
        assert_equal  "proto://user:pass@somehost.com:1234/projects/my_project",
                      MingleResource.site.to_s
      end
    
    end
    
  end
  
end
