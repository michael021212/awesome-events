Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "/auth/:provider/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :events do
    resources :tickets
  end
end
