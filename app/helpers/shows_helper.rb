module ShowsHelper

	def full_image_url(poster_path)
		poster_path.nil? ? "" : "https://image.tmdb.org/t/p/w185" + poster_path
	end

end
