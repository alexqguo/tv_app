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

	$(".show-link").click(displayLoadingModal);
});