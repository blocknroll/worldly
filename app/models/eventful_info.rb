class EventfulInfo

  def self.get_json_map_data
  EventfulService.get_events.map do |event|
    geo_data(event)
  end
end


  private

    def self.geo_data(event)
      {
            type: 'Feature',
            geometry: {
              type: 'Point',
              coordinates: [instagram.location.longitude, instagram.location.latitude]
            },
            properties: {}
          }
    end



end
