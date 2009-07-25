require 'rubygems'
require 'activesupport'
require 'activeresource'
require 'optparse'

prefix = File.join(File.dirname(__FILE_), "minglr")
require File.join(prefix, "mingle_resource")
require File.join(prefix, "mtx_options_parser")
require File.join(prefix, "minglr_options_parser")
require File.join(prefix, "minglr_config_parser")
require File.join(prefix, "input_cache")

resources = File.join(prefix, "resources", "*")
Dir[resources].each do |file_name|
  load file_name
end

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Minglr
  ROOT    = File.expand_path File.join(File.dirname(__FILE__), '..')
end