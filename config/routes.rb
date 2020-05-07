Rails.application.routes.draw do
  #get "/", to: "pages#10"
  #get "/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  get "/registrations/:step", to: "registrations#new", as: "new_registration"
  resources :registrations, only: [:create]
  get "/returning_teachers/:step", to: "returning_teachers#new", as: "new_returning_teacher"
  resources :returning_teachers, only: [:create]
  get "/primary_teachers/:step", to: "primary_teachers#new", as: "new_primary_teacher"
  resources :primary_teachers, only: [:create]
  get "/uk_teachers/:step", to: "uk_teachers#new", as: "new_uk_teacher"
  resources :uk_teachers, only: [:create]

end
