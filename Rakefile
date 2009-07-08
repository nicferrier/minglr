require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    if File.exist?('VERSION.yml')
      config = YAML.load(File.read('VERSION.yml'))
      gem.version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
    else
      gem.version = ""
    end
    gem.post_install_message = %q{PostInstall.txt}
    
    gem.name = "minglr"
    gem.summary = %q{command line user tool for Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management)}
    gem.description = %q{* This gem provides two executable binaries to interact with Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management) through its API. It also has sample interactive Rake task on how to facilitate easy card movements when a card enters/exits the development queue.  * mtx is a binary that facilities transition changes for use on rake tasks * minglr is a more interactive tool that provides a quick interface for many common uses}
    gem.email = "michael@schubert.cx"
    gem.homepage = "http://github.com/schubert/minglr"
    gem.authors = ["Michael Schubert", "Stephen Chu", "Chris O'Meara"]
    gem.executables = ["mtx", "minglr"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "minglr #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

