MINGLR_ENV = "test"

require "rubygems"
require "test/unit"

begin
  require "shoulda"
rescue LoadError
  puts "shoulda is not available. In order to run features, you must: sudo gem install thoughtbot-shoulda"
  exit 1
end
begin
  require "mocha"
rescue LoadError
  puts "mocha is not available. In order to run features, you must: sudo gem install mocha"
  exit 1
end

begin
  require "redgreen"
rescue LoadError
  # Don't really care if it is not available
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.dirname(__FILE__), "resources")
require "minglr"

class Test::Unit::TestCase
end
