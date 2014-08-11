module EpisodesHelper

	# TODO: need to redesign this to make it more efficient
	# store all of the user's views for the show upon loading the 
	# page and then just reference that?
	def viewed_by_current_user?(episode)
		current_user ? !!EpisodeView.find_by_user_and_episode(current_user.id, episode.id) : nil
	end

end
