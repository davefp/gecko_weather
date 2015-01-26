require 'open-uri'
require 'xmlsimple'

class WeatherController < ApplicationController

	respond_to :json
	
	def get
		puts params
		@raw_weather_data = open("http://weather.yahooapis.com/forecastrss?w=#{params[:id]}&u=#{params[:unit]}").read
		@wd = XmlSimple.xml_in(@raw_weather_data, { 'ForceArray' => false })['channel']['item']['condition']
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