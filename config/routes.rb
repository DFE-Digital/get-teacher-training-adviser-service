Rails.application.routes.draw do
  if Rails.configuration.x.enable_beta_redirects
    constraints(host: "beta-adviser-getintoteaching.education.gov.uk") do
      get "/(*path)", to: redirect(host: "adviser-getintoteaching.education.gov.uk")
    end
  end

  get "/(*path)", to: redirect(host: "getintoteaching.education.gov.uk", path: "/teacher-training-adviser/sign_up/identity?utm_source=adviser-getintoteaching.education.gov.uk&utm_medium=referral&utm_campaign=adviser_redirect")

  get "/teacher_training_adviser/not_available", to: "teacher_training_adviser/steps#not_available"

  get "/404", to: "errors#not_found", via: :all
  get "/403", to: "errors#forbidden", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  get "/robots.txt", to: "robots#show"

  resource :client_metrics, only: %i[create]

  namespace :teacher_training_adviser, path: "/teacher_training_adviser" do
    resources :feedbacks, only: %i[new create index] do
      collection do
        get :thank_you
        post :export
      end
    end
    resources :steps,
              path: "/sign_up",
              only: %i[index show update] do
      collection do
        get :completed
        get :resend_verification
      end
    end
  end

  resource :csp_reports, only: %i[create]

  get "/sitemap", to: "sitemaps#index"
  get "/healthcheck.json", to: "healthchecks#show", as: :healthcheck
  get "/privacy-policy", to: "pages#privacy_policy", as: :privacy_policy
  get "/cookies", to: "pages#cookies", as: :cookies
  get "/session-expired", to: "pages#session_expired", as: :session_expired

  resource "cookie_preference", only: %i[show]

  get "/:page", to: "pages#show"
end
