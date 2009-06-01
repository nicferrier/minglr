require 'rubygems'
require 'activesupport'
require 'activeresource'
require 'optparse'

require File.dirname(__FILE__) + '/minglr/mingle_resource'
require File.dirname(__FILE__) + '/minglr/mtx_options_parser'
require File.dirname(__FILE__) + '/minglr/minglr_options_parser'
require File.dirname(__FILE__) + '/minglr/minglr_config_parser'
require File.dirname(__FILE__) + '/minglr/card'
require File.dirname(__FILE__) + '/minglr/user'
require File.dirname(__FILE__) + '/minglr/property_definition'
require File.dirname(__FILE__) + '/minglr/attachment'
require File.dirname(__FILE__) + '/minglr/transition_execution'
require File.dirname(__FILE__) + '/minglr/input_cache'
require File.dirname(__FILE__) + "/version"

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Minglr
  VERSION = MINGLR_VERSION
  ROOT    = File.expand_path File.join(File.dirname(__FILE__), '..')
end