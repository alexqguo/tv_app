class ShowsController < ApplicationController

	def index
		@activities = []

		if !!current_user
			@activities = PublicActivity::Activity.order("created_at desc")
				.where(owner_id: current_user.followed_user_ids, owner_type: "User")
		end
	end

	def show
		@show = Show.find(params[:id])

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
				render json: {error: "Show not found"}, status: 404
			end
		else
			redirect_to root_url
		end
	end

	def view_season
		if request.xhr?
			begin
				season_num = params[:season_num]
				@show = Show.find(params[:show_id])

				if @show
					resp = @show.view_all_episodes_for_season(current_user, season_num)
					render json: resp
				else
					render json: {error: "Show not found"}, status: 404
				end
			rescue
				render json: {error: "This didn't work!"}, status: 422
			end
		else
			redirect_to root_url
		end
	end

	private

	def prepare_basic_info
		@seasons_count = @show.seasons.count
		@default_season = 1
		@views = !!current_user ? current_user.viewed_episode_ids_for_show(@show.id) : []
		@followed_users = !!current_user ? current_user.followed_users : []
	end

end
