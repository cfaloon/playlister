require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # DatabaseCleaner
  DatabaseCleaner.strategy = :transaction
  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean }

  # Add more helper methods to be used by all tests here...
end
