class EpisodesController < ApplicationController
	before_filter :require_current_user!, only: :view_episode

	def view_episode
		if request.xhr?
			# search for episode view, if exists, increment
			episode_id = params[:episode_id]
			view = EpisodeView.find_by_user_and_episode(current_user.id, episode_id)

			if view
				view.add_view!
			else
				view = current_user.episode_views.create(episode_id: params[:episode_id])
			end
			render json: {view_count: view.view_count}, status: 201
		end
	end

end
