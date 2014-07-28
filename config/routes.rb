Rails.application.routes.draw do
  
  resources :users, except: :destroy

  root to: "users#index"
end
