module EpisodesHelper

	def viewed_by_current_user?(episode)
		@views.include?(episode.id)
	end

end
