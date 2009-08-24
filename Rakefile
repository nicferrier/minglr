require 'rubygems'
require 'rake'

task :default => [:rcov]

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
    
    gem.add_dependency "httpclient"
    gem.add_dependency "activeresource", ">= 2.3.0"
    gem.add_dependency "activesupport", ">= 2.3.0"
    
    gem.add_development_dependency "thoughtbot-shoulda"
    gem.add_development_dependency "mocha"
    gem.add_development_dependency "spicycode-rcov"
    gem.add_development_dependency "cucumber"
    gem.add_development_dependency "redgreen"
    
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
    test.rcov_opts = ['--exclude', 'gems', "--text-report", "--only-uncovered"]
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

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

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features --format pretty"
  end
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task "ci" => ["rcov", "features", "gemspec", "build", "install"]
