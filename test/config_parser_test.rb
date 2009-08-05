require 'test_helper'

module Minglr
  
  class ConfigParserTest < Test::Unit::TestCase
    
    context "parse" do
    
      should "look for a config file in the user home directory or the current working directory" do
        File.expects(:exist?).with(File.join(ENV["HOME"], ".minglrconfig")).returns(true)
        #File.expects(:exist?).with(File.expand_path(File.join(ENV["PWD"], ".minglrconfig"))).returns(false)
        config_file_contents = ""
        File.expects(:read).with(File.join(ENV["HOME"], ".minglrconfig")).returns(config_file_contents)
        
        ConfigParser.parse
      end
      
      should "return the parsed configuration as a hash" do
        configuration_content = <<-EOS
          [foo]
            myfoo = myvalue
          [bar]
            mybar = yourvalue
        EOS
        
        File.stubs(:exist?).returns(true)
        File.expects(:read).returns(configuration_content)
        parsed_configuration = ConfigParser.parse
        
        assert_equal Hash, parsed_configuration.class
      end
      
      should "print a message if the config file cannot be found" do
        File.expects(:exist?).times(2).returns(false)
        ConfigParser.expects(:class_eval).with("send :exit, 1")
        ConfigParser.expects(:puts)
        ConfigParser.parse
      end
    
    end
    
    context "initialize" do
      
      should "parse the configuration file into sections and variables" do
        configuration_content = <<-EOS
          [foo]
            myfoo = myvalue
          [bar]
            mybar = yourvalue
        EOS
        
        parsed_configuration = ConfigParser.new(configuration_content)
        assert_equal true, parsed_configuration.config.has_key?(:foo)
        assert_equal true, parsed_configuration.config.has_key?(:bar)
        assert_equal true, parsed_configuration.config[:foo].has_key?(:myfoo)
        assert_equal true, parsed_configuration.config[:bar].has_key?(:mybar)
        assert_equal "myvalue", parsed_configuration.config[:foo][:myfoo]
        assert_equal "yourvalue", parsed_configuration.config[:bar][:mybar]
      end
      
      should "skip comment lines" do
        configuration_content = <<-EOS
          # [foo]
          #   bar = bad
          [foo]
            bar = baz
        EOS
        
        parsed_configuration = ConfigParser.new(configuration_content)
        assert_equal "baz", parsed_configuration.config[:foo][:bar]
      end
      
      should "skip blank lines" do
        configuration_content = <<-EOS

          [foo]
          
          [babble]
            bar = baz
        EOS
        
        parsed_configuration = ConfigParser.new(configuration_content)
        assert_equal "baz", parsed_configuration.config[:babble][:bar]
      end
      
      should "not redefine a section if it has already been defined" do
        configuration_content = <<-EOS
          [foo]
            bar = baz
            should = bekept
            
          [foo]
            bar = somethingelse
        EOS
        
        parsed_configuration = ConfigParser.new(configuration_content)
        assert_equal "somethingelse", parsed_configuration.config[:foo][:bar]
        assert_equal "bekept", parsed_configuration.config[:foo][:should]
      end
      
      should "set a section variable to the latest value allowing it to be redefined" do
        configuration_content = <<-EOS
          [foo]
            bar = baz
            bar = somethingelse
        EOS
        
        parsed_configuration = ConfigParser.new(configuration_content)
        assert_equal "somethingelse", parsed_configuration.config[:foo][:bar]
      end
      
    end
    
  end
  
end