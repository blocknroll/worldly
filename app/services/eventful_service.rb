require 'ostruct'

class EventfulService

  attr_reader :client

  def initialize
    # http://api.eventful.com/json/events/search?app_key=key&where=39.750081,-104.999703&within=5
    @client = Hurley::Client.new('http://api.eventful.com/json')
  end

  def get_events(location)
    response = client.get("events/search") do |request|
      request.query["app_key"] = ENV["eventful_key"]
      request.query["where"]   = "#{location[:lat]},#{location[:lon]}"
      # request.query["where"]   = "39.750081,-104.999703"
      request.query["within"]  = "3"
      request.options.timeout  = 1
    end
    events = parse(response.body)
    events[:events][:event]
  end

  def get_json_map_data(location: { lat: "39.750081", lon: "-104.999703" } )
    geo_data = get_events(location).map do |event|  # go to EventfulService > events, return the parsed hash, and map the Events data a new array
      geo_data(event)                               # create new 'geo_data' objects for each Event (in private method below)
    end
  end






      private

        def parse(response)
          JSON.parse(response, symbolize_names: true)
        end


        def geo_data(event)  # creates GeoJSON data with each event
          {
              type: 'Feature',
              geometry: {
                type: 'Point',
                coordinates: [ event[:longitude], event[:latitude] ]
              },
              properties: {
                title:      event[:title],
                venue_name: event[:venue_name],
                url:        event[:url],
                :'marker-color' => '#F38E19',
                :'marker-size' => 'small'
              }
          }
        end
end
