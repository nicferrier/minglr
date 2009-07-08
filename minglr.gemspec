# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{minglr}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Schubert", "Stephen Chu", "Chris O'Meara"]
  s.date = %q{2009-07-08}
  s.description = %q{* This gem provides two executable binaries to interact with Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management) through its API. It also has sample interactive Rake task on how to facilitate easy card movements when a card enters/exits the development queue.  * mtx is a binary that facilities transition changes for use on rake tasks * minglr is a more interactive tool that provides a quick interface for many common uses}
  s.email = %q{michael@schubert.cx}
  s.executables = ["mtx", "minglr"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "PostInstall.txt",
     "README.rdoc",
     "Rakefile",
     "bin/minglr",
     "bin/mtx",
     "lib/minglr.rb",
     "lib/minglr/attachment.rb",
     "lib/minglr/card.rb",
     "lib/minglr/input_cache.rb",
     "lib/minglr/mingle_resource.rb",
     "lib/minglr/minglr_action.rb",
     "lib/minglr/minglr_config_parser.rb",
     "lib/minglr/minglr_options_parser.rb",
     "lib/minglr/mtx_options_parser.rb",
     "lib/minglr/property_definition.rb",
     "lib/minglr/transition_execution.rb",
     "lib/minglr/user.rb",
     "minglrconfig.sample",
     "tasks/commit.sample.rake",
     "tasks/svn.sample.rake"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/schubert/minglr}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{command line user tool for Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management)}
  s.test_files = [
    "test/minglr_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
