class Event < OpenStruct

  # Class methods at the top
  def self.service
    @service ||= EventfulService.new  # get (or establish) a client connection to Eventful
  end

  def self.all
    service.events.map do |data|  # go to EventfulService > events, return the parsed hash, and map the Events data a new array
      Event.new(data)             # create new objects for each Event
    end
  end

  def self.find(id)
    Event.new(service.event(id))
  end


  def self.get_json_map_data
    service.events.map do |event|  # go to EventfulService > events, return the parsed hash, and map the Events data a new array
      geo_data(event)              # create new 'geo_data' objects for each Event (in private method below)
    end
  end


      private

          def self.geo_data(event)
            {
                type: 'Feature',
                geometry: {
                  type: 'Point',
                  coordinates: [ event[:longitude], event[:latitude] ]
                },
                properties: {
                  title:      event[:title],
                  venue_name: event[:venue_name],
                  :'marker-color' => '#63b6e5',
                  # :'marker-symbol' => 'post',
                  :'marker-size' => 'small'
                }
            }
          end



  # # Instance methods start here  (if no OpenStruct, need to hand-make these...)
  # attr_accessor :title,
  #               :description
  #
  # def initialize(data)
  #   @title       = data[:title]
  #   @description = data[:description]
  # end

end
