class MapsController < ApplicationController
  def index
    @geo_json = Event.get_json_map_data
    # binding.pry
  end

  def login
  end
end
