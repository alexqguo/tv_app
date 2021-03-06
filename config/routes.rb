Rails.application.routes.draw do
  
  resources :users, except: :destroy do
    get :find, on: :collection
    post :toggle_follow
    get 'viewed_ep_ids/:show_id', action: :viewed_ep_ids, as: :viewed_ep_ids
  end

  resources :episodes, only: [] do
  	post :view_episode
  end

  resources :shows, only: [:index, :show] do
  	get :search, on: :collection
  	post :fetch_episodes
    post 'view_season/:season_num', action: :view_season, as: :view_season
  	collection { get 'find/:tmdb_id', action: :find, as: :find }
	end

  resource :session, only: [:new, :create, :destroy]

  root to: "shows#index"
end
