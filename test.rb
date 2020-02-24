require "forecast_io"
require "httparty"



 
 
    @lat = 51.509865
    @lng = -0.118092

 ForecastIO.api_key = "2c29c734782bb3b17ce35a504f210207"
    forecast = ForecastIO.forecast("#{@lat}","#{@lng}").to_hash
    @current_temp = forecast["currently"]["temperature"]
    @current_summary = forecast["currently"]["summary"]
    @high = forecast["daily"]["data"][0]["temperatureHigh"]
    @low = forecast["daily"]["data"][0]["temperatureLow"]
    @forecast_array = forecast["daily"]["data"]
    num=forecast["daily"]["data"].length
    
    for i in 1..num-1
        day=forecast["daily"]["data"][i]
        puts day["temperatureHigh"]
        i=i+1
    end

        url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ba1a05fa57264086b9f93226b9982711"

     news = HTTParty.get(url).parsed_response.to_hash
     article = news["articles"]

     puts article.length


for num_article in article
    @headline=num_article["title"]
   @newsurl=num_article["url"]
   puts "news: #{@headline} source: #{@newsurl}"
end
