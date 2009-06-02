(in /Users/schubert/Work/minglr)
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{minglr}
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Schubert"]
  s.date = %q{2009-06-02}
  s.description = %q{* This gem provides two executable binaries to interact with Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management) through its API. It also has sample interactive Rake task on how to facilitate easy card movements when a card enters/exits the development queue.  * mtx is a binary that facilities transition changes for use on rake tasks * minglr is a more interactive tool that provides a quick interface for many common uses}
  s.email = ["michael@schubert.cx"]
  s.executables = ["mtx", "minglr"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "bin/mtx", "bin/minglr", "lib/minglr.rb", "lib/version.rb", "lib/minglr/attachment.rb", "lib/minglr/card.rb", "lib/minglr/input_cache.rb", "lib/minglr/mingle_resource.rb", "lib/minglr/minglr_action.rb", "lib/minglr/minglr_config_parser.rb", "lib/minglr/minglr_options_parser.rb", "lib/minglr/mtx_options_parser.rb", "lib/minglr/property_definition.rb", "lib/minglr/transition_execution.rb", "lib/minglr/user.rb", "tasks/commit.sample.rake", "tasks/svn.sample.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/schubert/minglr/tree/master}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{minglr}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{* This gem provides two executable binaries to interact with Mingle (http://mingle.thoughtworks.com/mingle-agile-project-management) through its API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.1.0"])
      s.add_runtime_dependency(%q<activeresource>, [">= 2.1.0"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.1.0"])
      s.add_dependency(%q<activeresource>, [">= 2.1.0"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.1.0"])
    s.add_dependency(%q<activeresource>, [">= 2.1.0"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
