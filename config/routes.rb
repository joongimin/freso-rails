FresoRails::Application.routes.draw do
  resources :routes

  root :to => "routes#index"
  get ':hash_key' => 'routes#redirect'

  resources :routes, only: [:index, :create]
end
