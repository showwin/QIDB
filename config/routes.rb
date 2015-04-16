Rails.application.routes.draw do

  root 'home#index'

  get 'search' => 'home#search', as: :search
  get 'download_csv' => 'home#output_csv', as: :download_csv
  post 'definitions/import' => 'definitions#import', as: :import
  get 'definitions/upload' => 'definitions#upload', as: :upload
  get 'definitions/confirm/:id' => 'definitions#confirm', as: :confirm_dup
  get 'definitions/success' => 'definitions#success', as: :def_success
  get 'definitions/:id/edit' => 'definitions#edit', as: :def_edit
  get 'definitions/:id/sheet' => 'definitions#pdf', as: :def_pdf
  get 'definitions/:prjt/:qid' => 'definitions#search', as: :def_search


  resources :definitions

  scope module: :api, path: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :definition_api, only: [:index]
    end
  end

end
