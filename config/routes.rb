Rails.application.routes.draw do

  root 'home#index'

  get 'search' => 'home#search', as: :search
  get 'download_csv' => 'home#output_csv', as: :download_csv
  post 'definitions/import' => 'definitions#import', as: :import
  get 'definitions/upload' => 'definitions#upload', as: :upload

  resources :definitions

  scope module: :api, path: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :definition_api, only: [:index]
    end
  end

end
