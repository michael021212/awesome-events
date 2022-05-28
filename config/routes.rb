Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/auth/:provider/callback' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resource :retirements, only: %i[new create]

  resources :events, only: %i[show new create edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  match '*path' => 'application#error404', via: :all
end
