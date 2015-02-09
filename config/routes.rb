Rails.application.routes.draw do

  root 'home#index'

  resources :definitions

  get 'search' => 'home#search', as: :search
  get 'download_csv' => 'home#output_csv', as: :download_csv

  scope module: :api, path: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :definition_api, only: [:index]
    end
  end

end
