require 'rubygems'
require 'sinatra/base'
require 'sinatra/config_file'
require 'mongoid'
require_relative 'models/init'
require_relative 'routes/init'

class ChickenApp < Sinatra::Base
  register Sinatra::ConfigFile

  enable :method_override
  enable :sessions
  set :session_secret, 'super secret'

  config_file '../config/chicken.yml'

  configure do
    set :app_file, __FILE__
    Mongoid.load! 'config/mongoid.yml'  
  end


  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :qa do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false #false will show nicer error page
    set :show_exceptions, false #true will ignore raise_errors and display backtrace in browser
  end

end
