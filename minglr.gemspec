require File.join(File.dirname(__FILE__), "lib", "version")

def manifest
  `git ls-files`.split("\n") - [".gitignore"]
end

Gem::Specification.new do |s|
  s.name     = "minglr"
  s.version  = MINGLR_VERSION
  s.date     = "2009-06-01"
  s.bindir          = 'bin'
  s.executables     << 'minglr'
  s.executables     << 'mtx'
  s.summary  = "Mingle command line tool"
  s.email    = "michael@schubert.cx"
  s.homepage = "http://github.com/schubert/minglr/tree/master"
  s.description = "Mingle command line tool"
  s.authors  = ["Stephen Chu", "Chris O'Meara", "Michael Schubert"]
  s.files    = manifest
end
