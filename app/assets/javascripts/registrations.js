var ready;
ready = function() {

	// Preview Image Before Upload
	function readURL(input) {

		console.log("It works on each visit!")

		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function (e) {
				$('#img-preview').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	$("#avatar-upload").change(function(){
		$('#img-preview').removeClass('hidden');
		readURL(this);
	});
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);