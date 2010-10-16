ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"
  map.brand_validation '/brand_validation', :controller => 'brands_status', :action => 'index'
  map.resources :brands
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

