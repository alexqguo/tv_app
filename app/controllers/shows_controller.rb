class ShowsController < ApplicationController

	def index
	end

	def search
		query = params[:q]
		@results = query.nil? ? nil : Tmdb::TV.find(query)
	end

end
