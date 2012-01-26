require 'open-uri'
require 'xmlsimple'

class WeatherController < ApplicationController

	respond_to :json
	
	def get
		@raw_weather_data = open("http://weather.yahooapis.com/forecastrss?w=#{params[:id]}&u=c").read
		@wd = XmlSimple.xml_in(@raw_weather_data, { 'ForceArray' => false })['channel']['item']['condition']
		@weather_text = {'item' => {'text' => "#{@wd['temp']}&deg;<br /> #{@wd['text']}"}}
		respond_with @weather_text
	end
end
