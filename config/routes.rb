Rails.application.routes.draw do
  
  resources :users, except: :destroy
  resources :shows, only: [:index, :show] do
  	get :search, on: :collection
  	post :fetch_episodes, on: :member
  	collection { get 'find/:tmdb_id', action: :find, as: :find }
	end
  resource :session, only: [:new, :create, :destroy]

  root to: "shows#index"
end
