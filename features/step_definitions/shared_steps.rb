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
    :scrum => {
      :url              => "http://localhost:9090/projects/scrum",
      :password         => "mingle",
      :status_property  => "cp_status",
      :username         => "schubert"
    }, 
    :global => {
      :default          => "blank",
      :username         => "schubert"
    },
    :storytracker => {
      :url              => "http://localhost:9090/projects/storytracker",
      :password         => "mingle",
      :status_property  => "cp_status",
      :username         => "schubert"
    },
    :xp => {
      :url => "http://localhost:9090/projects/xp",
      :password => "mingle",
      :username => "schubert"
    },
    :blank => {
      :url => "http://localhost:9090/projects/blank",
      :password => "mingle",
      :username => "schubert"
    },
    :agilehybrid => {
      :url => "http://localhost:9090/projects/agilehybrid",
      :password => "mingle",
      :status_property => "cp_status",
      :username=>"schubert"
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