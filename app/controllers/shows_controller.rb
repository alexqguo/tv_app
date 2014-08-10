class ShowsController < ApplicationController

	def index
		# popular shows?
	end

	def show
		@show = Show.find_by_id(params[:id])
		@seasons = @show.sorted_seasons
	end

	def search
		@query = params[:q]
		@results = @query.nil? ? nil : Tmdb::TV.find(@query)
	end

	def find
		@show = Show.find_by_tmdb_id(params[:tmdb_id])
		unless @show
			@show = Show.create(show_params)
			# @show.get_seasons
		end

		redirect_to @show
	end

	def fetch_episodes
		if request.xhr?
			fail
			# @show = something
			# @show.get_seasons
		end
	end

	private
	def show_params
		params.require(:show).permit(:tmdb_id)
	end

end
