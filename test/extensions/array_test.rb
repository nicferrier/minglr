require 'test_helper'

module Minglr
  module Extensions
  
    class ArrayTest < Test::Unit::TestCase

      context Array do
    
        context "filter" do
          
          setup do
            class TestObject
              attr_accessor :name
            end
            @test1 = TestObject.new
            @test2 = TestObject.new
            @test1.name = "test1"
            @test2.name = "test2"
            @collection = [@test1, @test2]
            @collection.send(:extend, Minglr::Extensions::Array)
          end
          
          should "include elements matching words in attributes" do
            assert_equal [@test1], @collection.filter([:name], ["1"])
            assert_equal [@test1, @test2], @collection.filter([:name], ["test"])
          end

          should "deal with empty words and attributes" do
            assert_equal [@test1, @test2], @collection.filter([], [])
            assert_equal [@test1, @test2], @collection.filter([:name], [])
            assert_equal [], @collection.filter([], ["1"])
          end
    
        end
    
      end

    end
  end
end