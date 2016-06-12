Rails.application.routes.draw do

  # Users routes
  post 'users'                   => 'users#create'
  put 'users'                    => 'users#update'
  delete 'users'                 => 'users#destroy'
  
  # Topics routes
  get 'users/topics'             => 'topics#index'
  post 'users/topics'            => 'topics#create'
  post 'users/topics/new_viewer' => 'topics#add_viewer'
  get 'users/topics/viewers'     => 'topics#get_viewers'
  put 'topics'                   => 'topics#update'
  delete 'users/topics'          => 'topics#destroy'
  
  # Cards routes
  get 'topics/cards'             => 'cards#index'
  post 'topics/cards'            => 'cards#create'
  put 'cards'                    => 'cards#update'
  delete 'topics/cards'          => 'cards#destroy'
  get 'topics/cards/answers'     => 'cards#get_answers'
  
  
  # resources :users, param: :email, :only => [:create, :update, :destroy] do
  #   resources :topics, :except => [:show, :new, :edit, :update]
  # end
  
  # resources :topics, :only => [:update] do
  #   post 'new_viewer/:email' => 'topics#add_viewer'
  #   resources :cards, :except => [:new, :edit]
  # end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
