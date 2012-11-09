GeckoWeather::Application.routes.draw do
  
  get 'weather/:id' => 'weather#get'
  get 'weather/:id/scale' => 'weather#get_scale'
  
  get 'flickr/:id' => 'flickr#get'
end
