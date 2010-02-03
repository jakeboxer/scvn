function setupHints (hasHintClass, showHintClass) {
	$('input.' + hasHintClass).each(function () {
		// Grab the text box and its title
		var box      = $(this);
		var boxTitle = box.attr('title');
		
		if(boxTitle != ''){
			// If the text box has a title, set up the blur and focus functions
			box.blur(function () {
				if(box.val() == ''){
					box.val(boxTitle);
					box.addClass(showHintClass);
				}
			});
			
			box.focus(function () {
				if(box.hasClass(showHintClass) && (box.val() === boxTitle)){
					box.val('');
					box.removeClass(showHintClass);
				}
			});
		}
	});
}

$(document).ready(function () {
	setupHints('has-hint', 'show-hint');
})