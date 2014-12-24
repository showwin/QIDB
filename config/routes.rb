Rails.application.routes.draw do

  root 'home#index'

  resources :definitions

  get 'search' => 'home#search', as: :search

  scope module: :api, path: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :definition_api, only: [:index]
    end
  end

end
