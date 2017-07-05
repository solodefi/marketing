var ready;
ready = function() {

	function readURL(input) {
		if (input.files && input.files[0]) {
			//console.log(input.files[0].name);
			console.log(input.files[0].name);
			var x = document.getElementById("proposal-attachments-upload");
			var txt = "";
			if ('files' in x) {
			    if (x.files.length == 0) {
			        txt = "Select one or more files.";
			    } else {
			        for (var i = 0; i < x.files.length; i++) {
			            var file = x.files[i];
			            if ('name' in file) {
			                txt += file.name + "<br>";
			            }
			        }
			    }
			}
			document.getElementById ("proposal_attachment_div").innerHTML = txt;
		}
	}

	$("#proposal-attachments-upload").change(function(){
		readURL(this);
	});
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);