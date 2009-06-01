Gem::Specification.new do |s|
  s.name     = "minglr"
  s.version  = "0.1.0.3"
  s.date     = "2009-06-01"
  s.bindir          = 'bin'
  s.executables     << 'minglr'
  s.executables     << 'mtx'
  s.summary  = "Mingle command line tool"
  s.email    = "michael@schubert.cx"
  s.homepage = "http://github.com/schubert/minglr/tree/master"
  s.description = "Mingle command line tool"
  s.authors  = ["Stephen Chu", "Chris O'Meara", "Michael Schubert"]
  s.files    = Dir["bin/*"] + Dir["*.txt"] + Dir["lib/minglr/*.rb"] + Dir["lib/*.rb"] + ["minglr.gemspec", "Rakefile", "README.rdoc", "minglrconfig.sample"] + Dir["tasks/*"]
end
