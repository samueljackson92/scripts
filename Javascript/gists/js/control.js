//control.js
//Author: Samuel Jackson
//Date: 30/06/2013
//Description: Get friends gists from github

var GIT_API = "https://api.github.com/"

$(document).ready(function() {

	var btnUser = $("#username-submit");
	btnUser.click(function(evt) {
		var username = $("#username").val();
		$.get(GIT_API + "users/" + username + "/following", function(data) {
			
			getUserGists(0, data);

		}).done(function() {
			btnUser.parents("#username-form").fadeOut();
		}).fail(function(data) {
		});
	});

});

function getUserGists(index, data) {
	var user = data[index].login;
	$.get(GIT_API + "users/" + data[index].login + "/gists", function(data) {
		console.log(user)
		console.log(data);
	});

	if(index < data.length-1) {
		getUserGists(index+1, data);
	}
}
