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
        
        setup do
          @object1 = stub("Object", :name => "Foo", :description => "Bar")
          @object2 = stub("Object", :name => "Bar", :description => "Frobble")
          @collection = [@object1, @object2]
          @attributes = [:name, :description]
        end
        
        should "print values of attributes of objects separated by dashes and aligning columns of values" do
          Base.expects(:puts).with("Foo - Bar    ")
          Base.expects(:puts).with("Bar - Frobble")
          Base.print_collection(@collection, @attributes)
        end
        
        should "allow for right adjusted values" do
          Base.expects(:puts).with("Foo -     Bar")
          Base.expects(:puts).with("Bar - Frobble")
          Base.print_collection(@collection, @attributes, :right)
        end
        
      end
      
    end

  end

end