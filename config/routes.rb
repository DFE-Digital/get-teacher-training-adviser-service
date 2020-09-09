Rails.application.routes.draw do
  root "pages#home"

  namespace :teacher_training_adviser, path: "/teacher_training_adviser" do
    resources :steps,
              path: "/sign_up",
              only: %i[index show update] do
      collection do
        get :completed
        get :resend_verification
      end
    end
  end

  get "/sitemap", to: "sitemaps#index"
  get "/healthcheck.json", to: "healthchecks#show", as: :healthcheck
  get "/privacy-policy", to: "pages#privacy_policy", as: :privacy_policy
  get "/session-expired", to: "pages#session_expired", as: :session_expired

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all
end
