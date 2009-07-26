require 'rubygems'
require 'activesupport'
require 'activeresource'
require 'optparse'

prefix = File.join(File.dirname(__FILE__), "minglr")
require File.join(prefix, "action")
require File.join(prefix, "options_parser")
require File.join(prefix, "config_parser")

mtx = File.join(prefix, "mtx", "*")
Dir[mtx].each do |file_name|
  load file_name
end

require File.join(prefix, "resources", "base")
resources = File.join(prefix, "resources", "*")
Dir[resources].each do |file_name|
  load file_name
end

extensions = File.join(prefix, "extensions", "*")
Dir[extensions].each do |file_name|
  load file_name
end

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Minglr
  ROOT    = File.expand_path File.join(File.dirname(__FILE__), '..')
end