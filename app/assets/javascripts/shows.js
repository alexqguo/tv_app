/*
This file contains javascript for shows pages
*/

$(function() {
	function displayLoadingModal() { //don't really need this right now
		$(".modal, .loading-modal").show();
	}

	function showEpisodes(data) {
		$("#show-episodes").removeClass("need-to-fetch");
		$(".episodes").html(data);
	}

	function handleEpisodeView(data) {
		// add css class or do something
	}

	function viewEpisode(evt) {
		evt.preventDefault();
		var episodeId = $(evt.target).data("episode-id");
		$.post("/episodes/" + episodeId + "/view_episode", handleEpisodeView);
	}

	// $(".show-link").click(displayLoadingModal);

	// Saving episode view
	$(".episode-view-link").click(viewEpisode);
	
	// Ajax for saving episodes
	if ($("#show-episodes").hasClass("need-to-fetch")) {
		alert("fetching");
		var showId = $("#show").data("id");
		$.post("/shows/" + showId + "/fetch_episodes", showEpisodes);
	}

});