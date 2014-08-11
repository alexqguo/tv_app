module EpisodesHelper

	# TODO: need to redesign this to make it more efficient
	# store all of the user's views for the show upon loading the 
	# page and then just reference that?
	# do this: on loading of the page, create a hash of user views for the show
	# it will look like this: {
	# 	episode_id: view_count
	# }
	# and then you can pass that into the view as well do do checks
	def viewed_by_current_user?(episode)
		current_user ? !!EpisodeView.find_by_user_and_episode(current_user.id, episode.id) : nil
	end

end
