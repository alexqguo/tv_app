/*
This file contains javascript for shows pages
*/

$(function() {
	/*
		Eventually we should wait to save seasons/episodes until we save the show and load its page
	*/
	function displayLoadingModal() {
		$(".modal, .loading-modal").show();
	}

	function showEpisodes() {
		$(".episodes").removeClass("need-to-fetch");
	}

	$(".show-link").click(displayLoadingModal);

	if ($(".episodes").hasClass("need-to-fetch")) {
		$.post("shows/1/fetch_episodes", showEpisodes);
	}
});