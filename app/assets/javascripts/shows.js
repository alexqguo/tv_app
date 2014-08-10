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

	// $(".show-link").click(displayLoadingModal);
	
	if ($("#show-episodes").hasClass("need-to-fetch")) {
		alert("fetching");
		var showId = $("#show").data("id");
		$.post("/shows/" + showId + "/fetch_episodes", showEpisodes);
	}

});