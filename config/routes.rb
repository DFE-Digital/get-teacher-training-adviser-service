Rails.application.routes.draw do
  #get "/", to: "pages#10"
  #get "/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  get '/overseas_candidate_confirmation', to: 'overseas_candidate_confirmations#confirmation'
  resources :identities, only: %i(new create)
  resources :returning_to_teachings, only: %i(new create) 
  resources :returned_teachers, only: %i(new create)
  resources :primary_or_secondaries, only: %i(new create)
  resources :primaries, only: %i(new create)
  resources :date_of_births, only: %i(new create)
  resources :uk_or_overseas, only: %i(new create)
  resources :uk_candidate_postcodes, only: %i(new create)
  resources :uk_candidate_addresses, only: %i(new create)
  resources :overseas_candidate_contacts, only: %i(new create)
  resources :overseas_candidate_confirmations, only: %i(new create)
  


end