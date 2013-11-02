require "yaml"
require "active_record"
require "twitter"
require "database_cleaner"

config = YAML.load_file( 'config.yml' )
ActiveRecord::Base.establish_connection(config["db"]["test"])

Dir[File.join(File.dirname(__FILE__), "..", "models", "*.rb")].each do |f|
  require f
end

Dir[File.join(File.dirname(__FILE__), "..", "*.rb")].each do |f|
  require f
end

=begin
RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
=end