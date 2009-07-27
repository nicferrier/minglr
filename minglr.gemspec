# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{minglr}
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Schubert", "Stephen Chu", "Chris O'Meara"]
  s.date = %q{2009-07-26}
  s.description = %q{* This gem provides two executable binaries to interact with Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management) through its API. It also has sample interactive Rake task on how to facilitate easy card movements when a card enters/exits the development queue.  * mtx is a binary that facilities transition changes for use on rake tasks * minglr is a more interactive tool that provides a quick interface for many common uses}
  s.email = %q{michael@schubert.cx}
  s.executables = ["mtx", "minglr"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "PostInstall.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "bin/minglr",
     "bin/mtx",
     "cucumber.yml",
     "features/cards.feature",
     "features/step_definitions/minglr_steps.rb",
     "features/step_definitions/shared_steps.rb",
     "features/users.feature",
     "lib/minglr.rb",
     "lib/minglr/action.rb",
     "lib/minglr/config_parser.rb",
     "lib/minglr/extensions/array.rb",
     "lib/minglr/mtx/input_cache.rb",
     "lib/minglr/mtx/options_parser.rb",
     "lib/minglr/options_parser.rb",
     "lib/minglr/resources/attachment.rb",
     "lib/minglr/resources/base.rb",
     "lib/minglr/resources/card.rb",
     "lib/minglr/resources/project.rb",
     "lib/minglr/resources/property_definition.rb",
     "lib/minglr/resources/transition_execution.rb",
     "lib/minglr/resources/user.rb",
     "minglr.gemspec",
     "minglrconfig.sample",
     "tasks/commit.sample.rake",
     "tasks/svn.sample.rake",
     "test/action_test.rb",
     "test/commands_test.rb",
     "test/config_parser_test.rb",
     "test/extensions/array_test.rb",
     "test/options_parser_test.rb",
     "test/resources/attachment_test.rb",
     "test/resources/base_test.rb",
     "test/resources/card_test.rb",
     "test/resources/project_test.rb",
     "test/resources/property_definition_test.rb",
     "test/resources/user_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/schubert/minglr}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{command line user tool for Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management)}
  s.test_files = [
    "test/action_test.rb",
     "test/commands_test.rb",
     "test/config_parser_test.rb",
     "test/extensions/array_test.rb",
     "test/options_parser_test.rb",
     "test/resources/attachment_test.rb",
     "test/resources/base_test.rb",
     "test/resources/card_test.rb",
     "test/resources/project_test.rb",
     "test/resources/property_definition_test.rb",
     "test/resources/user_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
