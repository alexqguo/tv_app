$(function() {

	function followUserCallback(data) {
		$(".follow-link").toggle();
		console.log(data);
		
		if (data.nowFollowing) {
			alert("You followed");
		} else {
			alert("You unfollowed");
		}
	}

	function toggleFollow(evt) {
		evt.preventDefault();
		var url = $(evt.target).data("url");
		$.post(url, followUserCallback);
	}

	$(".follow-link").click(toggleFollow);

});