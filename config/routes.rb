Freso::Application.routes.draw do
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'logout', to: 'sessions#destroy', as: 'logout'
  controller :sessions do
    get "sessions/logged_out" => :logged_out
    get "sessions/facebook" => :facebook
    get "sessions/twitter" => :twitter
  end

  scope ":current_locale", current_locale: /#{I18n.available_locales.join("|")}/ do
    resources :authentications
    resources :brands do
      member do
        get :select_layout
        put :update_layout
        get :customize_tutorial
        get :customize
        get :menu
      end
    end
    resources :translations, :except => :show
    resources :layout_templates
    resources :layouts
    resources :faq_categories

    controller :home do
      get "login" => :index
      get "step_slide" => :step_slide
    end

    controller :nuvo do
      get "nuvo/login" => :login
      get "nuvo/callback" => :callback
    end

    resources :faq_categories
    resources :users

    root :to => "home#index"

    match "*a", :to => "home#no_route_matched"
  end

  controller :javascript_exception do
    post "javascript_exception" => :create
  end

  match "*path", :to => "home#no_locale_matched"
  match "", :to => "home#no_locale_matched"
end