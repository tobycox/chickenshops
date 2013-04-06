require 'google_places'
require 'mongoid'
require 'mongoid_search'

class Shop
  include Mongoid::Document
  include Mongoid::Search
 
  field :name, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  
  search_in :name

  def self.refresh
    client = GooglePlaces::Client.new('AIzaSyCyTE6vUV34Y1xgrygJ-6NH6ropEwLECOE')
    spots = client.spots(51.5171, 0.1062, :radius => 50000, :name => 'chicken', :radar => true);
    spots.each do |spot|
      shop = Shop.create :name => spot.name, :latitude => spot.lat, :longitude => spot.lng
      shop.save
    end
  end

end
