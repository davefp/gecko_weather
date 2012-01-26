require 'open-uri'

class FlickrController < ApplicationController

	respond_to :jpg

	def get
		FlickRaw.api_key = 'df4df3308bfbb2e1d5fa399791a5251c'
		FlickRaw.shared_secret = '51e38a3c3dc4d772'
		
		user_id = flickr.people.findByUsername(:username => params[:id]).id
		
		photos = flickr.people.getPublicPhotos :user_id => user_id
		response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
		response.headers['Content-Type'] = 'image/jpeg'
		response.headers['Content-Disposition'] = 'inline'
		render :text => open(FlickRaw.url_b(photos[rand(photos.size)])).read
	end

end
