/*
This file contains javascript for shows pages
*/

$(function() {
	// This is for moveEpisodeInfo
	// Define it up here for performance in the scroll event handler
	var $window = $(window),
			$epInfo = $("#highlighted-episode"),
			epInfoTop = $epInfo.offset().top;

	function displayLoadingModal() {
		$(".modal, .loading-modal").show();
	}

	function usernameButton(name, id) {
		return "<a href='/users/" + id + "' class='episode-button username-button'>" + 
						name + "</a>";
	}

	function showEpisodes(data) {
		$("#show-episodes").removeClass("need-to-fetch");
		$(".episodes").html(data);
		$(".season-tab-1").click();
	}

	function handleEpisodeView(evt, data) {
		$(evt.target).parents(".episode").addClass("viewed");
		$(evt.target).html("Rewatch");
	}

	function highlightFollowedUserEpisodes(evt, data) {
		var name = $(evt.target).html();
		var id = $(evt.target).data("id");
		for (var i = 0; i < data.length; i++) {
			$(".episode.episode-" + data[i]).append(usernameButton(name, id));
		};
	}

	function getFollowedUserViews(evt) {
		var url = $(evt.target).data("url");
		$.get(url, highlightFollowedUserEpisodes.bind(undefined, evt));
		$(".username-button").remove();
	}

	function viewEpisode(evt) {
		evt.preventDefault();
		var episodeId = $(evt.target).data("episode-id");
		$.post("/episodes/" + episodeId + "/view_episode", handleEpisodeView.bind(undefined, evt));
	}

	function showFollowedUsers(evt) {
		$(".followed-users").fadeToggle("fast");
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

	function handleWatchAll(evt, data) {
		var season = ".season-" + data["season"];
		$(season + " .episode").addClass("viewed");
	}

	function moveEpisodeInfo(evt) {
		$epInfo.toggleClass("sticky", $window.scrollTop() > (epInfoTop - 36));
	}

	function watchAll(evt) {
		var showId = $("#show").data("id");
		var season = $(evt.target).parents(".season-actions").data("season");
		var url = "/shows/" + showId + "/view_season/" + season;
		$.post(url, handleWatchAll.bind(undefined, evt));
	}

	// Saving episode view
	$(".episodes").on("click", ".episode-view-link", viewEpisode);

	// Showing episode details
	$(".episodes").on("click", ".episode", showEpisodeDetails);
	
	// Toggle Seasons
	$(".episodes").on("click", ".season-tab", toggleSeasons);

	// Watch all episodes for season
	$(".episodes").on("click", ".action-button.watch-all", watchAll);

	// Compare with followed users
	$(".compare-with").click(showFollowedUsers);

	// Show episode views for followed user
	$(".followed-user").click(getFollowedUserViews);

	// Move Episode Info
	// TODO: I don't like having a scroll event but oh well
	$window.scroll(moveEpisodeInfo);

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

	// Show episode and season by default if params are given
	var urlSeason = urlParams["season"];
	var urlEpisode = urlParams["episode"];
	if (urlSeason && urlEpisode) {
		$(".season-tab-" + urlSeason).click();
		$(".season-" + urlSeason + " .ep-num-" + urlEpisode).click();
	}

});