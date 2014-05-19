FresoRails::Application.routes.draw do
  root to: redirect('http://crema.me')
  get ':hash_key' => 'routes#redirect'

  resources :routes, only: :create
end
