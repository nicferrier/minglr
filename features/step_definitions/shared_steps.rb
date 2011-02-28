require "test/unit/assertions"
require File.join(File.dirname(__FILE__), "..", "..", "lib", "minglr")
World(Test::Unit::Assertions)

module Kernel

  def capture_stdout
    $stdout = $cucumberout
    yield
    return $cucumberout
  ensure
    $stdout = STDOUT
  end
 
end

def rc_config
  { 
    :global => {
      :default          => "blank",
      :username         => "test_user"
    },
    :sample_project => {
      :url              => "http://192.168.56.101:8080/projects/sample_project/",
      :password         => "test_password",
      :status_property  => "cp_status",
      :username         => "test_user"
    } 
  }
end

def execute_minglr_command(project, action, extra_arguments = [])
  $cucumberout = StringIO.new
  extra_arguments = [] if extra_arguments.nil?
  uri_options = rc_config[:global] || {}
  original_arguments = ([project, action] + extra_arguments)
  
  uri_options.merge! rc_config[project.to_sym]
  Resources::Base.configure uri_options
  Resources::Attachment.configure
  extra_options = Minglr::OptionsParser.parse(original_arguments)
  
  output = capture_stdout do
    Minglr::Action.execute(action, original_arguments, extra_options, rc_config[project.to_sym])
  end
  output.string.strip
end
