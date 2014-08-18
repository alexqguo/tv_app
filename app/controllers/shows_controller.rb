class ShowsController < ApplicationController

	def index
		# popular shows?
	end

	def show
		@show = Show.find_by_id(params[:id])

		if @show
			@seasons = @show.sorted_seasons
			prepare_basic_info
		else
			redirect_to root_url
		end
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

			if @show
				@show.get_seasons
				prepare_basic_info
				render partial: "episodes", locals: { seasons: @show.sorted_seasons }
			else
				render json: {}, status: 400
			end
		end
	end

	private

	def prepare_basic_info
		@seasons_count = @show.seasons.count
		@default_season = 1
		@views = !!current_user ? current_user.viewed_episode_ids_for_show(@show.id) : []
	end

end
