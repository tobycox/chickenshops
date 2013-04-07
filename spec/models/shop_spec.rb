require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Shop do
  before :each do
    @spot = OpenStruct.new :id => 'someid', :name => 'thename'
    GooglePlaces::Client.any_instance.stub(:spots).and_return [@spot]
  end

  it "populate from a search result" do 
    Shop.refresh settings.google_api_key      
    Shop.all.count.should eq 1
  end


  it "updates existing entries" do
    shop = Shop.create :place_id => @spot.id, :name => 'oldname' 
    
    Shop.refresh settings.google_api_key
    Shop.all.count.should eq 1
    Shop.first.name.should eq @spot.name
  end
end
