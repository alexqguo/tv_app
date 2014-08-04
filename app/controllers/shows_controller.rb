class ShowsController < ApplicationController

	def index
		# popular shows?
	end

	def show
		@show = Show.find_by_id(params[:id])
	end

	def search
		@query = params[:q]
		@results = @query.nil? ? nil : Tmdb::TV.find(@query)
	end

	def find
		@show = Show.find_by_tmdb_id(params[:tmdb_id])
		@show = Show.create(tmdb_id: params[:tmdb_id]) unless @show

		redirect_to @show
	end

end
