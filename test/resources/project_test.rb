require 'test_helper'

module Resources
  
  class ProjectTest < Test::Unit::TestCase
  
    context Project do
    
      context "configure" do
        
        should "subtract the project name from the url" do
          options = { :username => "user",
                      :password => "pass",
                      :url => "proto://somehost.com:1234/projects/my_project" }
          Base.configure(options)
          Project.configure
          assert_equal  "/projects", Project.prefix
        end
      
      end
    
    end

  end
  
end