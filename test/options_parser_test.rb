require 'test_helper'

module Minglr
  
  class OptionsParserTest < Test::Unit::TestCase
    
    context "parse" do
      
      should "gather all property definitions for a given project" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.expects(:project_options).returns([[:column_name, "Some Column Name"]])
        OptionsParser.expects(:puts)
        OptionsParser.parse(["--version"])
      end
      
      should "warn about authentication if property definition gathering fails" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.expects(:project_options).raises(ActiveResource::UnauthorizedAccess, stub(:code => "BadAccess"))
        OptionsParser.expects(:puts).at_least(1)
        OptionsParser.expects(:puts).with("Connection Failed.  Response code = BadAccess. to http://foo.bar")
        OptionsParser.expects(:puts).with("Did you set 'basic_authentication_enabled: true' in your auth_config.yml file?")
        OptionsParser.parse(["--version"])
      end
      
      should "parse name option" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.stubs(:project_options).returns([])
        options = OptionsParser.parse(["-n", "MyName"])
        
        assert_equal true, options.has_key?(:name)
        assert_equal "MyName", options[:name]
      end
      
      should "parse description option" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.stubs(:project_options).returns([])
        options = OptionsParser.parse(["-d", "MyDescription"])
        
        assert_equal true, options.has_key?(:description)
        assert_equal "MyDescription", options[:description]
      end
      
      should "parse type option" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.stubs(:project_options).returns([])
        options = OptionsParser.parse(["-t MyType"])
        
        assert_equal true, options.has_key?(:card_type_name)
        assert_equal "MyType", options[:card_type_name]
      end
      
      should "parse comment option" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.stubs(:project_options).returns([])
        options = OptionsParser.parse(["-c MyComment"])
        
        assert_equal true, options.has_key?(:comment)
        assert_equal "MyComment", options[:comment]
      end
      
      should "parse file option" do
        Resources::Base.site = "http://foo.bar"
        Resources::PropertyDefinition.stubs(:project_options).returns([])
        options = OptionsParser.parse(["-f MyFile"])
        
        assert_equal true, options.has_key?(:file_attachment)
        assert_equal "MyFile", options[:file_attachment]
      end
      
    end
    
  end
  
end
