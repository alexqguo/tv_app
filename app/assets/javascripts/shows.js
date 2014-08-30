/*
This file contains javascript for shows pages
*/

$(function() {
	function displayLoadingModal() {
		$(".modal, .loading-modal").show();
		console.log("asdf");
	}

	function showEpisodes(data) {
		$("#show-episodes").removeClass("need-to-fetch");
		$(".episodes").html(data);
		$(".season-tab-1").click(); // 
	}

	function handleEpisodeView(evt, data) {
		// add css class or do something
		$(evt.target).parent().addClass("viewed");
	}

	function viewEpisode(evt) {
		evt.preventDefault();
		var episodeId = $(evt.target).data("episode-id");
		$.post("/episodes/" + episodeId + "/view_episode", handleEpisodeView.bind(undefined, evt));
	}

	function showEpisodeDetails(evt) {
		$(".episode-info").hide();
		var id = $(evt.target).data("episode-id");
		$(".episode-" + id).show();
	}

	function toggleSeasons(evt) {
		var $target = $(evt.target);
		var season = $target.data("season-number");

		currentSeason.hide();
		currentSeason = $(".season-" + season).show();
		$(".season-tab.current-season").removeClass("current-season");
		$target.addClass("current-season");
	}

	// Saving episode view
	$(".episodes").on("click", ".episode-view-link", viewEpisode);

	// Showing episode details
	$(".episodes").on("click", ".info-button", showEpisodeDetails);
	
	// Toggle Seasons
	$(".episodes").on("click", ".season-tab", toggleSeasons);
	
	// Ajax for saving episodes
	if ($("#show-episodes").hasClass("need-to-fetch")) {
		var showId = $("#show").data("id");
		displayLoadingModal();
		$.post("/shows/" + showId + "/fetch_episodes", showEpisodes);
	}

	// Display the default season
	if ($("#all-seasons").length) {
		var defaultSeason = $("#all-seasons").data("default-season");
		var currentSeason = $(".season-" + defaultSeason).show();
		$(".season-tab-" + defaultSeason).addClass("current-season");
	}

});