Freso::Application.routes.draw do
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'logout', to: 'sessions#destroy', as: 'logout'

  scope ":current_locale", current_locale: /#{I18n.available_locales.join("|")}/ do
    resources :authentications
    resources :brands
    resources :users
    resources :translations, :except => :show
    resources :layout_templates do
      collection do
        get "layout_templates_list"
      end
    end
    resources :layouts
    resources :faq_categories

    controller :home do
      get "login" => :index
      get "step_slide" => :step_slide
    end

    root :to => "home#index"

    match "*a", :to => "home#no_route_matched"
  end

  match "*path", :to => "home#no_locale_matched"
  match "", :to => "home#no_locale_matched"
end
