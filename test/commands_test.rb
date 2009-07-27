require 'test_helper'

module Minglr
  
  class CommandsTest < Test::Unit::TestCase

    context Action::Commands do
      
      setup do
        @options = []
        @flag_options = {}
        @config = { :status_property => "cp_status", :username => "user", :password => "password" }
      end
      
      context "attach" do
        
        should "parse card number and file number as options and call resource" do
          @options << "1"
          @flag_options[:file_attachment] = "file"
          
          Resources::Attachment.expects(:attach).with("1", "file", "user", "password")
          Action::Commands.attach(@options, @flag_options, @config)
        end
    
      end 
  
      context "card" do
    
        should "parse card number and call resource" do
          @options << "1"
          
          Resources::Card.expects(:print_card).with("1", "cp_status")
          Action::Commands.card(@options, @flag_options, @config)
        end
    
      end
  
      context "cards" do
    
        should "call resource" do
          Resources::Card.expects(:print_all).with(@options, "cp_status")
          Action::Commands.cards(@options, @flag_options, @config)
        end
    
      end
  
      context "create" do
    
        should "call resource" do
          Resources::Card.expects(:create).with(@flag_options, "cp_status")
          Action::Commands.create(@options, @flag_options, @config)
        end
    
      end
  
      context "fetch" do
    
        should "parse card number and call resource" do
          @options << "1"
          
          Resources::Attachment.expects(:fetch).with("1", "user", "password")
          Action::Commands.fetch(@options, @flag_options, @config)
        end
    
      end
  
      context "move" do
    
        should "parse card number and call resource" do
          @options << "1"

          Resources::Card.expects(:move).with("1", @flag_options, @config)
          Action::Commands.move(@options, @flag_options, @config)
        end
  
      end
  
      context "projects" do
    
        should "call resource" do
          Resources::Project.expects(:print_all).with(@options, "cp_status")
          Action::Commands.projects(@options, @flag_options, @config)
        end
    
      end
  
      context "update" do
    
        should "parse card number and call resource" do
          @options << "1"
          
          Resources::Card.expects(:update).with("1", @flag_options)
          Action::Commands.update(@options, @flag_options, @config)
        end
    
      end
  
      context "users" do
    
        should "call resource" do
          Resources::User.expects(:print_all).with(@options)
          Action::Commands.users(@options, @flag_options, @config)
        end
  
      end
  
    end
  
  end
  
end