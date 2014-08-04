module ShowsHelper

	def full_image_url(show)
		if show.poster_path
			"https://image.tmdb.org/t/p/w154" + show.poster_path
		elsif show.backdrop_path
			"https://image.tmdb.org/t/p/w185" + show.backdrop_path
		end
	end

end
