require 'test_helper'

module Resources
  
  class PropertyDefinitionTest < Test::Unit::TestCase
  
    context PropertyDefinition do
    
      context "project_options" do
        
        should "collect all property definitions into an array of arrays" do
          property1 = stub("PropertyDefinition", :column_name => "cp_name", :name => "Name")
          property2 = stub("PropertyDefinition", :column_name => "cp_accepted_on_iteration_card_id", :name => "Accepted in Iteration")
          PropertyDefinition.expects(:find).with(:all).returns([property1, property2])
          
          assert_equal PropertyDefinition.project_options, [[:cp_name, "Name"], [:cp_accepted_on_iteration_card_id, "Accepted in Iteration"]]
        end
      
      end
    
    end
  
  end
  
end