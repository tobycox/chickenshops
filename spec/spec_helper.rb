require 'sinatra'
require 'sinatra/config_file'
require 'mongoid'

Sinatra::Base.environment = 'test'

Dir[File.join(File.dirname(__FILE__), '..', 'app.rb')].each {|file| require file }

config_file '../config/chicken.yml'

RSpec.configure do |config|

  config.before :each do
    Mongoid.default_session.collections.each { |coll| coll.drop unless /^system/.match(coll.name) }
  end

end

