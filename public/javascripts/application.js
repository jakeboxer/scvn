// Show a text box's hint
function showHint (box, showHintClass) {
	if(box.val() == ''){
		box.val(box.attr('title'));
		box.addClass(showHintClass);
	}
}

// Clear a hint from the text box
function clearHint (box, showHintClass) {
	if(box.hasClass(showHintClass) && (box.val() === box.attr('title'))){
		box.val('');
		box.removeClass(showHintClass);
	}
}

// Sets up hint text on all input boxes with titles and the specified class.
function setupHints (hasHintClass, showHintClass) {
	$('input.' + hasHintClass).each(function () {
		// Grab the text box and its title
		var box      = $(this);
		var boxTitle = box.attr('title');
		
		// If the text box has a title...
		if(boxTitle != ''){
			// Set up the blur function
			box.blur(function () {
				showHint(box, showHintClass);
			});
			
			// Set up the focus function
			box.focus(function () {
				clearHint(box, showHintClass);
			});
			
			// Start the box off as blurred
			box.blur();
			
			// When the form is submitted, clear the hint
			$(this.form).submit(function () {
				clearHint(box, showHintClass);
			});
		}
	});
}

function setupAutoSelect (autoSelectClass) {
	$('.' + autoSelectClass).click(function () {
		$(this).select();
	});
}

$(document).ready(function () {
	setupHints('has-hint', 'show-hint');
	setupAutoSelect('has-autoselect');
});
