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
      
      context "print_all" do
        
        should "print list of all projects" do
          project1 = Project.new
          project2 = Project.new
          Project.expects(:find).with(:all).returns([project1, project2])
          Project.expects(:print_collection).with([project1, project2], [:name, :description])
          Project.print_all          
        end
        
        should "print warning if no projects are found" do
          Project.expects(:find).with(:all).returns([])
          Project.expects(:warn).with("No projects found")
          Project.print_all
        end
      
      end
    
    end

  end
  
end