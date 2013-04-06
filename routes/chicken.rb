require 'json'

class ChickenApp < Sinatra::Base

  get '/' do

    response.headers['Access-Control-Allow-Origin'] = 'http://maps.googleapis.com'
    erb :index
  end

  get '/shops.json' do
    Shop.refresh if Shop.all.count == 0
    @shops = params[:filter] ? Shop.full_text_search(params[:filter]) : Shop.all

    content_type 'json'
    @shops.to_json
  end
end
