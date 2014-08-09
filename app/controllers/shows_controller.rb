class ShowsController < ApplicationController

	def index
		# popular shows?
	end

	def show
		@show = Show.find_by_id(params[:id])
		@seasons = @show.seasons
	end

	def search
		@query = params[:q]
		@results = @query.nil? ? nil : Tmdb::TV.find(@query)
	end

	def find
		@show = Show.find_by_tmdb_id(params[:tmdb_id])
		unless @show
			@show = Show.create(tmdb_id: params[:tmdb_id])
			@show.get_seasons
		end

		redirect_to @show
	end

	private
	def show_params
		# TODO
	end

end
