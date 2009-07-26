require 'test_helper'

module Minglr
  
  class ConfigParserTest < Test::Unit::TestCase
    
    context "parse" do
    
      should "look for a config file in the user home directory or the current working directory" do
      end
      
      should_eventually "return the parsed configuration as a hash" do
      end
      
      should_eventually "print a message if the config file cannot be found" do
      end
    
    end
    
    context "initialize" do
      
      should_eventually "parse the configuration file into sections and variables" do
      end
      
      should_eventually "skip comment lines" do
      end
      
      should_eventually "skip blank lines" do
      end
      
      should_eventually "not define a section if it has already been defined" do
      end
      
      should_eventually "set a section variable to the latest value allowing it to be redefined" do
      end
      
    end
    
  end
  
end