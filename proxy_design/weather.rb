require_relative "proxy_interface"
require 'json'
require 'net/http'

class WeatherProxy < ProxyInterface
  def initialize(obj)
    @obj = obj
  end

  def __makeRequest(location)
    weather = Net::HTTP.get(
        URI("http://api.openweathermap.org/data/2.5/forecast?q=#{location}&APPID=e84231f43b16ef79cf230882ea42f2aa")
    )
  end

  def processInfo
    JSON.parse(__makeRequest(@obj.processInfo))
  end
end