Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'


  match "/auth/:provider/callback" => 'sessions#create', as: "login_callback", via: [:get, :post]
  get 'logout', to: "sessions#destroy"
  resources :password_resets, only: [:show, :update, :new, :create]

  resource :session, only: [:new, :create]

  resources :voter_guides do
    resources :guide_reports, only: [:new, :create], as: :reports
    resources :supporters, only: [:create, :index]
    member do
      patch :publish
    end
  end

  resources :accounts, only: :show
  resources :email_confirmations, only: [:new, :create, :show]
  resources :unsubscribes, only: [:show, :update]

  resources :endorsements, only: :update
  resources :registrations, only: :new
  resources :guide_collections, only: [:index, :show]
end
