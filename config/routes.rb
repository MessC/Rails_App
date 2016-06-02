Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'

  root									'static_pages#home'
  get 		'help'		=>	'static_pages#help'
	get 		'about'		=>	'static_pages#about'
	get 		'contact'	=>	'static_pages#contact'
	get 		'signup'	=>	'users#new'
	get 		'login'   => 	'sessions#new'
	post 		'login'   => 	'sessions#create'
	delete 	'logout'  => 	'sessions#destroy'
	
	# 12.15: Adding following and followers actions to the Users controller (generates our RESTful route to look like /users/#/following it was just :users)
	resources :users do
    member do
      get :following, :followers
    end
  end

	resources :account_activations, only: [:edit] # 10.1 adding a resource for account activations and named route for edit action
  resources :password_resets,     only: [:new, :create, :edit, :update] # 10.37 Adding a resource for password resets
  resources :microposts,          only: [:create, :destroy] # 11.30 Routes for the micropost resource
  resources :relationships,       only: [:create, :destroy] # 12.20: Adding the routes for user relationships

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'sample_app#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
