require 'test_helper'

module Resources
  
  class BaseTest < Test::Unit::TestCase
  
    context Base do
    
      context "configure" do
      
        should "combine options to build url" do
          options = { :username => "user",
                      :password => "pass",
                      :url => "proto://somehost.com:1234/projects/my_project" }
          Base.configure(options)
          assert_equal  "proto://user:pass@somehost.com:1234/projects/my_project",
                        Base.site.to_s
        end
    
      end
    
    end

  end

end