spec = Gem::Specification.new do |s|
  s.name = "redis-bloomfilter"
  s.version = "0.1"
  s.author = "Charles H. Martin, PhD"
  s.homepage    = "http://github.com/charlesmartin14/redis-bloomfilter"
  s.rubyforge_project = "redis-bloomfilter"
  s.platform = Gem::Platform::RUBY
  s.summary     = "Redis-based Bloom Filter implemented in Ruby using CityHash"
  s.require_path = "lib"


  s.add_dependency "redis", ">=3.0.3"   
  s.add_dependency "hiredis", "~> 0.4.5"
  s.add_dependency "cityhash", "~> 0.7.0"

  s.add_development_dependency "rake", ">=10.0.0"
  s.add_development_dependency "rspec", ">=2.12.0"
  s.add_development_dependency "eventmachine"
  s.add_development_dependency "em-synchrony"


  s.files = %w[
    LICENSE.txt
    CHANGELOG.rdoc
    README.rdoc
    Rakefile
  ] + Dir['lib/**/*.rb']

  s.test_files = Dir['spec/*.rb']
end
