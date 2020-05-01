Rails.application.routes.draw do
  get "/", to: "pages#10"
  get "/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all


  resources :identities, only: %i(new create)
  resources :returning_to_teachings, only: %i(new create) 
  resources :returned_teachers, only: %i(new create)
  resources :primary_or_secondaries, only: %i(new create)

end