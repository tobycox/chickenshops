require 'sinatra'
require 'mongoid'
Dir[File.join(File.dirname(__FILE__), '..', 'app.rb')].each {|file| require file }

set :environment, :test



