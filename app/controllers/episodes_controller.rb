class EpisodesController < ApplicationController
	before_filter :require_current_user!, only: :view_episode

	def view_episode
		if request.xhr?
			render json: {}
		end
	end

end
