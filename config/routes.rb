Rails.application.routes.draw do
  
  resources :users, except: :destroy
  resource :session, only: [:new, :create, :destroy]

  root to: "users#index"
end
