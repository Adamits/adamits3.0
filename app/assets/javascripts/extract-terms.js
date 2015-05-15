/**
***Get the 10 highest scored terms
***Get the list of words in the post
***Compare and replace each word in the post with itself
***inside of a span tag with class="highlight"
***where the word matches one of the terms
**/

$(document).ready(function () {
	$(".js-term-extraction").each(function() {
	  $(this).find($(".js-extract-button")).click(function() {
			$(this).closest($(".js-term-extraction")).find($(".post-content")).each(function() {
				if (document.getElementsByClassName('highlight')[0] != 'undefined') {
					var terms = $(this).data("extracted-terms"); //10 highest weighted terms
					var new_content = "";
					$(this).text().split(' ').forEach(function(word) { //Loop over each word in the post
						wordMatch = word.replace(/[^a-zA-Z0-9 - ' _]/, "").toLowerCase();
						if ($.inArray(wordMatch, terms) != -1) {
							var punct = word.match(/[^a-zA-Z0-9 - ' _]/);
							if (punct) {
								word = word.replace(/[^a-zA-Z0-9 - ' _]/, "");
								new_content = new_content + highlight(word) + punct[0] + " ";
							} else {
								new_content = new_content + highlight(word) + " ";
							}
						} else {
							new_content = new_content + word + " ";
						}
					});
				$(this).html(new_content);
				}
			});
		});
	});
});

function highlight (word) {
	var before = "<span class='highlight'>";
	var after = "</span>";
	return before + word + after;
}