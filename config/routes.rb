Twilater::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root to: 'home#welcome'

  resources :contents, only: [:index, :show] do
    get 'page/:page', action: :index, on: :collection, as: :page

    collection do
      get :search
    end
  end

  resources :identities, only: :index

  get '/auth/:provider/callback' => 'sessions#create'

  get '/auth/failure' => 'sessions#failure'

  delete '/signout' => 'sessions#destroy', as: :signout

end
