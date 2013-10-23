FresoRails::Application.routes.draw do
  resources :routes

  root :to => "routes#index"
  get ':key' => 'routes#redirect'

  resources :routes do

  end
end
