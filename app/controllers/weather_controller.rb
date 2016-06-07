require 'open-uri'
require 'xmlsimple'

class WeatherController < ApplicationController

	respond_to :json
	
	def get
    @raw_weather_data = open("https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%20#{params[:id]}%20and%20u%20%3d%20'#{params[:unit]}'&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").read
    json = JSON.parse(@raw_weather_data)
    @wd = json['query']['results']['channel']['item']['condition']
		#{"item":{"text":"<div class='t-size-x72'>-6&deg;</div><div>Cloudy</div>"}}
		@weather_text = {'item' => [{'text' => "<div class='t-size-x72'>#{@wd['temp']}&deg;</div><div>#{@wd['text']}</div>"}]}
		respond_with @weather_text
	end
	
	def get_scale
		@raw_weather_data = open("http://weather.yahooapis.com/forecastrss?w=#{params[:id]}&u=#{params[:unit]}").read
		@wd = XmlSimple.xml_in(@raw_weather_data, { 'ForceArray' => false })['channel']['item']['condition']
		@forecast = XmlSimple.xml_in(@raw_weather_data, { 'ForceArray' => false })['channel']['item']['forecast'][0]
		@weather_text = {'item' => @wd['temp'], 'min' => @forecast['low'], 'max' => @forecast['high']}
		respond_with @weather_text
	end
end
