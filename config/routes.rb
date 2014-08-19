Rails.application.routes.draw do
  
  resources :users, except: :destroy do
    post :follow_user
    delete :unfollow_user
  end

  resources :episodes, only: [] do
  	post :view_episode
  end

  resources :shows, only: [:index, :show] do
  	get :search, on: :collection
  	post :fetch_episodes
  	collection { get 'find/:tmdb_id', action: :find, as: :find }
	end

  resource :session, only: [:new, :create, :destroy]

  root to: "shows#index"
end
