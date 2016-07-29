require 'pp'
require 'json'

require_relative "ip"
require_relative "location"
require_relative "weather"

                                                #Ugur Buyukdurak

start = Proc.new do |weatherObj|
  weatherInfo = weatherObj.processInfo

  city = weatherInfo["city"]["name"]
  maxTemp = weatherInfo["list"][0]["main"]["temp_max"]
  minTemp = weatherInfo["list"][0]["main"]["temp_min"]
  pressure = weatherInfo["list"][0]["main"]["pressure"]
  humidity = weatherInfo["list"][0]["main"]["humidity"]
  seaLevel = weatherInfo["list"][0]["main"]["sea_level"]

  puts "City is #{city}"
  puts "MaxTemp is #{maxTemp}"
  puts "MinTemp is #{minTemp}"
  puts "Pressure is #{pressure}"
  puts "Humidity is #{humidity}"
  puts "Sea Level is #{seaLevel}"

  puts "\nMade By Ugur Buyukdurak"

end

weather = WeatherProxy.new(LocationProxy.new(IpProxy.new))
start.call(weather)






