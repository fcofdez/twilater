Twilater::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root to: 'home#welcome'

  get '/home' => 'home#index', as: :home

  get '/auth/:provider/callback' => 'sessions#create'

  get '/auth/failure' => 'sessions#failure'

  delete '/signout' => 'sessions#destroy', as: :signout

end
