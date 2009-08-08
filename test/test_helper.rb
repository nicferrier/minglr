MINGLR_ENV = "test"

require "rubygems"
require "test/unit"

require "shoulda"
require "mocha"
require "redgreen"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.dirname(__FILE__), "resources")
require "minglr"

class Test::Unit::TestCase
end
