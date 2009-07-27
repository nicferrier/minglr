MINGLR_ENV = "test"

require "rubygems"
require "test/unit"
begin
  require "shoulda"
rescue LoadError
  puts "Missing shoulda: sudo gem install thoughtbot-shoulda --source=http://gems.github.com/"
end
begin
  require "mocha"
rescue LoadError
  puts "Missing mocha: sudo gem install mocha"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.dirname(__FILE__), "resources")
require "minglr"

class Test::Unit::TestCase
end
