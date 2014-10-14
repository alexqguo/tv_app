class EpisodesController < ApplicationController
	before_filter :require_current_user!, only: [:view_episode, :view_season]

	def view_episode
		if request.xhr?
			#TODO search for episode view, if exists, increment
			episode_id = params[:episode_id]
			view = EpisodeView.find_by_user_and_episode(current_user.id, episode_id)

			if view
				view.add_view!
			else
				view = current_user.episode_views.create(episode_id: params[:episode_id])
			end

			view.episode.create_activity :create, owner: current_user
			render json: {episode_id: view.episode.id, view_count: view.view_count}, status: 201
		else
			redirect_to root_url
		end
	end

end
