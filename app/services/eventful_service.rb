class EventfulService

  attr_reader :client

  def initialize
    @client = Hurley::Client.new('http://api.eventful.com/json')
  end

  def events
    response = client.get("events/search") do |request|
      request.query["app_key"] = ENV["eventful_key"]
      request.query["where"]   = "39.750081,-104.999703"
      request.query["within"]  = "3"
      request.options.timeout  = 1
    end
    events = parse(response.body)
    events[:events][:event]
  end

  # def event(id)
  #   response = client.get("events/get") do |request|
  #     request.query["app_key"] = ENV["eventful_key"]
  #     request.query["id"]      = id   # "E0-001-000213902-2"
  #     request.options.timeout  = 1
  #   end
  #   parse(response.body)
  # end


      private

        def parse(response)
          JSON.parse(response, symbolize_names: true)
        end
end
