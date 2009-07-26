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
      
      context "warn" do
        
        should "prepend message with warning" do
          Base.expects(:puts).with("Warning: test")
          Base.warn("test")
        end
      
      end
      
      context "print_collection" do
        
        should_eventually "print values of attributes of objects separated by dashes and aligning columns of values" do
        end
        
        should_eventually "allow for right adjusted values" do
        end
        
      end
      
    end

  end

end