ActionController::Routing::Routes.draw do |map|
  # Prefix all the unshortened urls with /unshortened
  map.with_options :path_prefix => :unshortened do |unshortened|
    unshortened.resources :addresses, :member => { :goto => :get }
    unshortened.resources :tags,
      :only       => [:show],
      :collection => { :namesearch => :get, :find => :get }
  end
  
  # The root page where you create new addresses
  map.root :controller => :addresses, :action => :new
  
  # Shortcut for /unshortened/addresses/xyz/goto
  map.goto_shortened ':id', :controller => :addresses, :action => :goto
end
