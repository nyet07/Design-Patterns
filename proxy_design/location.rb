require_relative "proxy_interface"
require 'json'
require 'net/http'

class LocationProxy < ProxyInterface
  def initialize(obj)
    @obj = obj
  end

  def __makeRequest(ip)
    json = Net::HTTP.get(
        URI("http://geoip.nekudo.com/api/#{ip}")
    )
  end

  def processInfo
    JSON.parse(__makeRequest(@obj.processInfo))["city"]
  end
end