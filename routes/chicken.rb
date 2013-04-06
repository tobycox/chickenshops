class ChickenApp < Sinatra::Base

  get '/' do
    response.headers['Access-Control-Allow-Origin'] = 'http://maps.googleapis.com'
    erb :index
  end

end
