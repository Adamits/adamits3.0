$(document).ready(function () {
	$("#Admin").click(function () {
		$("#sign-in-screen").show()
		$("#sign-in-close").click(function () {
			$("#sign-in-screen").hide()
		});
	});
});
