class ShowsController < ApplicationController

	def index
		# popular shows?
	end

	def show
		@show = Show.find_by_id(params[:id])
		@seasons = @show.sorted_seasons
		@views = !!current_user ? current_user.viewed_episode_ids_for_show(@show.id) : []
	end

	def search
		@query = params[:q]
		@results = @query.nil? || @query == "" ? [] : Tmdb::TV.find(@query)
	end

	def find
		@show = Show.find_by_tmdb_id(params[:tmdb_id])
		unless @show
			@show = Show.create(tmdb_id: params[:tmdb_id])
		end

		redirect_to @show
	end

	def fetch_episodes
		if request.xhr?
			@show = Show.find(params[:show_id])
			@show.get_seasons

			render partial: "episodes", locals: { seasons: @show.sorted_seasons }
		end
	end

end
