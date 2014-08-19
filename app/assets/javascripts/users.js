$(function() {

	function followUserCallback(follow) {
		$(".follow-link").toggle();
		if (follow) {
			alert("You followed");
		} else {
			alert("You unfollowed");
		}
	}
	
	function followUser(evt) {
		evt.preventDefault();
		var url = $(evt.target).data("url");
		$.post(url, followUserCallback.bind(undefined, true));
	}

	function unfollowUser(evt) {
		evt.preventDefault();
		var url = $(evt.target).data("url");
		$.ajax({
			url: url, 
			type: "DELETE",
			success: followUserCallback.bind(undefined, false)
		});
	}

	$(".follow-link.follow").click(followUser);
	$(".follow-link.unfollow").click(unfollowUser);

});