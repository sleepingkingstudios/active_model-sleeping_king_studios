# active_model-sleeping_king_studios.gemspec

$: << './lib'
require 'active_model/sleeping_king_studios/version'

Gem::Specification.new do |gem|
  gem.name        = 'active_model-sleeping_king_studios'
  gem.version     = ActiveModel::SleepingKingStudios::VERSION
  gem.date        = Time.now.utc.strftime "%Y-%m-%d"
  gem.summary     = 'A collection of ActiveModel concerns and extensions.'
  gem.description = <<-DESCRIPTION
    A collection of concerns and extensions to add functionality to ActiveModel
    objects and collections. The features can be included individually or by
    category. For more information, check out the README.
  DESCRIPTION
  gem.authors     = ['Rob "Merlin" Smith']
  gem.email       = ['merlin@sleepingkingstudios.com']
  gem.homepage    = 'http://sleepingkingstudios.com'
  gem.license     = 'MIT'

  gem.require_path = 'lib'
  gem.files        = Dir["lib/**/*.rb", "LICENSE", "*.md"]

  gem.add_runtime_dependency 'activemodel', '~> 4.2'

  gem.add_development_dependency 'appraisal', '~> 1.0',  '>= 1.0.2'
  gem.add_development_dependency 'byebug',    '~> 3.5',  '>= 3.5.1'
  gem.add_development_dependency 'rake',      '~> 10.4', '>= 10.4.2'

  gem.add_development_dependency 'rspec',                       '~> 3.1'
  gem.add_development_dependency 'rspec-collection_matchers',   '~> 1.1', '>= 1.1.2'
  gem.add_development_dependency 'rspec-sleeping_king_studios', '>= 2.0.0.rc.0'
end # gemspec
