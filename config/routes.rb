Freso::Application.routes.draw do
  

  match '/auth/:provider/callback' => 'authentications#create'

  scope ":current_locale", current_locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    }
    resources :users
    resources :authentications
    resources :translations, :except => :show
    resources :layouts

    resources :layout_templates do
      collection do
        get "layout_templates_list"
      end
    end

    root :to => "home#index"
    controller :home do
      get "login" => :index
      get "step_slide" => :step_slide
    end

    controller :nuvo do
      get "nuvo/login" => :login
      get "nuvo/callback" => :callback
    end

    resources :faq_categories
    resources :brands

    match "*a", :to => "home#no_route_matched"
  end

  match "*path", :to => "home#no_locale_matched"
  match "", :to => "home#no_locale_matched"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
