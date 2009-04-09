Gem::Specification.new do |s|
  s.name     = "minglr"
  s.version  = "0.1.0.1"
  s.date     = "2009-04-09"
  s.summary  = "Consists of Rake task helpers and a command line utility to help transitioning story cards on Mingle through the Mingle API. Plugs right into your routine \"test > code > check-in > move card\" build process."
  s.email    = "github@stephenchu.com"
  s.homepage = "http://github.com/stephenchu/minglr/tree/master"
  s.description = "Do you forget to update a story card on Mingle when the card has moved into developers' hands? How about forgetting to update the story card to kick-off its sign off process when story is completed? If we let these sloppiness happen too often, communication flow will be hindered, and the time it takes to provide business value through story completions will be lengthened. Fortunately, Minglr can help."
  s.authors  = ["Stephen Chu", "Chris O'Meara", "Michael Schubert"]
  s.files    = ["bin/mtx", "bin/minglr", "History.txt", "lib/minglr/attachment.rb", "lib/minglr/card.rb", "lib/minglr/input_cache.rb", "lib/minglr/mingle_resource.rb", "lib/minglr/mtx_options_parser.rb", "lib/minglr/minglr_options_parser.rb", "lib/minglr/transition_execution.rb", "lib/minglr/minglr_action.rb", "lib/minglr/user.rb", "lib/minglr_config_parser.rb", "lib/minglr.rb", "Manifest.txt", "minglr.gemspec", "PostInstall.txt", "Rakefile", "README.rdoc", "minglrconfig.sample", "tasks/commit.sample.rake", "tasks/svn.sample.rake"]
end
