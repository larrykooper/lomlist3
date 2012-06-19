Lomlist3::Application.routes.draw do
  devise_for :users, :skip => :registrations 

  match '/items' => 'items#index', :via => :get
  match '/items' => 'items#create', :via => :post
  match '/items/:number' => 'items#show', :via => :get
  match '/items/:number' => 'items#update', :via => :put
  match '/items/:number' => 'items#destroy', :via => :delete
  match '/items/:number/edit' => 'items#edit', :via => :get
  match '/items/new' => 'items#new', :via => :get
  match '/items/new_next' => 'items#new_next', :via => :post
  match '/items/printview' => 'items#printview', :via => :get
  match '/items/edit_by_number' => 'items#edit'
  match '/items/delete_by_number' => 'items#destroy'
  match '/items/search' => 'items#search'

  resources :tags do
    collection do
      get 'tag_report'
    end
  end

  resources :act_types
  
  match 'list/:tagname' => 'items#index', :tagname =>  /[^\/]+/
  match 'acttype/:typename' => 'items#search_by_act_type'
  
  root :to => 'items#index'   

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
