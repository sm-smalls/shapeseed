Shapeseed::Application.routes.draw do
  
  resources :user_sessions
  resources :works, :only => [:create, :destroy, :show] do
    member do 
      get :tags
    end
  end
  resources :relationships, :only => [:create, :destroy]
  resources :contributions
  resources :mentorships
  resources :searches
  resources :users do
    member do
      get :following, :followers, :mentors, :contributeds
    end
  end
  resources :people do
    member do
	  get :tags, :works, :mentees, :contributors
	end
  end

  root :to => 'pages#home'
  
  #These create xx_path => '/xx' and xx_url => 'localhost:3000/xx'
  match '/contact',   :to => 'pages#contact'
  match '/about',     :to => 'pages#about'
  match '/signup',    :to => 'users#new'
  match '/relations', :to => 'users#relations'
  match '/suggest',   :to => 'users#suggest'
  match '/contribute', :to => 'people#contribute'
  #match 'login',	  :to => 'user_sessions#new', :as => :login
  match 'logout', 	  :to => 'user_sessions#destroy', :as => :logout
  #match '/signup:invitation_token', :to => 'users#new'
  #match '/signin',    :to => 'sessions#new'
  #match '/signout',   :to => 'sessions#destroy'
  
  #for errors...keep it at end to catch everything for now. 
  match '*path', 	  :to => 'pages#home'
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
