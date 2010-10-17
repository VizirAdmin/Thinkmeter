ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"
  map.resources :brands
  map.resources :opinions
  map.resources :expressions  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
