Rails.application.routes.draw do
  
  resources :users, except: :destroy do
    post :toggle_follow
    get 'viewed_ep_ids/:show_id', action: :viewed_ep_ids, as: :viewed_ep_ids
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
