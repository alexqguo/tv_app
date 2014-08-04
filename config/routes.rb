Rails.application.routes.draw do
  
  resources :users, except: :destroy
  resources :shows, only: :index
  resource :session, only: [:new, :create, :destroy]

  root to: "shows#index"
end
