require_relative "proxy_interface"
require 'json'
require 'net/http'

class IpProxy < ProxyInterface
  def __makeRequest
    json = Net::HTTP.get(
        URI("http://api.ipify.org?format=json")
    )
  end

  #Returns raw ip address.
  def processInfo
    JSON.parse(__makeRequest)["ip"]
  end
end