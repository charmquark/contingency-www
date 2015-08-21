Rails.application.routes.draw do
    resources :games do
        resources :background_images, only: ['index', 'new', 'create', 'destroy'], format: false
        resources :game_memberships, path: 'members', only: ['index', 'new', 'create', 'destroy'], format: false
    end
    
    resources :members, constraints: {member_id: /[^\/]+/} do
        resources :background_images, only: ['index', 'new', 'create', 'destroy'], format: false
        resources :external_links, only: ['index', 'new', 'create', 'destroy'], format: false
        resources :game_memberships, path: 'games', only: ['index', 'new', 'create', 'destroy'], format: false
    end
    
    resources :news_posts

    get     'login'     => 'sessions#new'       , as: :login        , format: false
    post    'login'     => 'sessions#create'    , as: :process_login, format: false
    delete  'logout'    => 'sessions#destroy'   , as: :logout       , format: false
    
    root 'pages#home'

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
