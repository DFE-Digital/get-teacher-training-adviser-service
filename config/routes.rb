Rails.application.routes.draw do
  root "pages#10"
  get "/sitemap", to: "sitemaps#index"
  get "/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  get "/registrations/*step_name", to: "registrations#new", as: "new_registration"
  post "/registrations/*step_name", to: "registrations#create", as: "registrations"

end

