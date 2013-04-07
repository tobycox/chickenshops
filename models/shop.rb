require 'google_places'
require 'mongoid'
require 'mongoid_search'

class Shop
  include Mongoid::Document
  include Mongoid::Search

  field :place_id, type: String
  field :name, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  
  search_in :name

  def self.refresh(api_key)
    client = GooglePlaces::Client.new(api_key)
    spots = client.spots(51.5171, 0.1062, :radius => 50000, :name => 'chicken', :radar => true);
    spots.each do |spot|
      shop = Shop.find_or_initialize_by(place_id: spot.id)
      shop.update_attributes :name => spot.name, :latitude => spot.lat, :longitude => spot.lng
    end
  end

end
