Rails.application.routes.draw do
  devise_for :users, skp: [:saml_authenticatable]
  root "welcome#index"
  get "welcome/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # devise_for :users, skip: [ :saml_authenticatable ]
  devise_scope :user do
    # SSO Routes
    get "users/saml/sign_in" => "saml_sessions#new", as: :new_saml_user_session
    post "users/saml/auth" => "saml_sessions#create", as: :user_sso_session
    match "users/saml/sign_out" => "saml_sessions#destroy", as: :destroy_user_sso_session, via: [ :get, :post ]
    get "users/saml/metadata" => "saml_sessions#metadata", as: :metadata_user_sso_session
  end
  get "session_activity/destroy"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
