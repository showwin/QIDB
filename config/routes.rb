Rails.application.routes.draw do
  root 'home#index'

  get 'search' => 'home#search', as: :search
  get 'login' => 'home#login', as: :login
  get 'logout' => 'home#logout', as: :logout
  get 'download_csv' => 'home#output_csv', as: :download_csv
  post 'definitions/import' => 'definitions#import', as: :import
  get 'definitions/upload' => 'definitions#upload', as: :upload
  get 'definitions/confirm/:id' => 'definitions#confirm', as: :confirm_dup
  get 'definitions/success' => 'definitions#success', as: :def_success
  get 'definitions/:id/edit' => 'definitions#edit', as: :def_edit
  get 'definitions/:id/duplicate' => 'definitions#duplicate', as: :def_duplicate
  get 'definitions/:id/sheet' => 'definitions#pdf', as: :def_pdf
  get 'definitions/:id/en' => 'definitions#show_en', as: :def_en
  get 'definitions/:id/output_csv_data' => 'definitions#output_csv_data', as: :def_csv_data
  get 'definitions/select' => 'definitions#select', as: :def_select
  get 'definitions/pdfs' => 'definitions#pdfs', as: :def_pdfs
  get 'definitions/table' => 'definitions#show_table', as: :def_show_table
  get 'definitions/table_en' => 'definitions#show_table_en', as: :def_show_table_en
  get 'definitions/:prjt/:qid' => 'definitions#search', as: :def_search
  get 'definitions/:prjt/:qid/sheet' => 'definitions#search_pdf', as: :def_search_pdf
  get 'definitions/:prjt/:qid/en' => 'definitions#search_en', as: :def_search_en

  resources :definitions

  scope module: :api, path: 'api', defaults: { format: 'json' } do
    namespace :v1 do
      resources :definitions, only: [:index]
    end
  end
end
