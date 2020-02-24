require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"


def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "2c29c734782bb3b17ce35a504f210207"


get "/" do
  view "ask"
end

get "/news" do
   results = Geocoder.search(params["location"])
    @lat_lng = results.first.coordinates
    @lat = @lat_lng[0]
    @lng = @lat_lng[1]
    @coordinates = "#{@lat},#{@lng}"
    @location_name = params["location"]

    ForecastIO.api_key = "2c29c734782bb3b17ce35a504f210207"
    forecast = ForecastIO.forecast("#{@lat}","#{@lng}").to_hash
    @current_temp = forecast["currently"]["temperature"]
    @current_summary = forecast["currently"]["summary"]
    @high = forecast["daily"]["data"][0]["temperatureHigh"]
    @low = forecast["daily"]["data"][0]["temperatureLow"]
    @forecast_array = forecast["daily"]["data"]
    @num=forecast["daily"]["data"].length
    





    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ba1a05fa57264086b9f93226b9982711"

     news = HTTParty.get(url).parsed_response.to_hash
@article = news["articles"]
   


    view "news"
end