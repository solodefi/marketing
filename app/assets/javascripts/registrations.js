var ready;
ready = function() {

	// Preview Image Before Upload
	function readURL(input) {

		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function (e) {
				$("#rotation_angle").val(0);
				$('#img-profile-source').attr('src', e.target.result);

				var cropzoom = $('#crop_container').cropzoom({ 
				    width:500,
				    height:500,
				    bgColor: '#CCC',
				    enableRotation:true,
				    enableZoom:false,
				    zoomSteps:10,
				    rotationSteps:10,
				    selector:{
				      centered:true,
				      startWithOverlay: true,
				      borderColor:'blue',
				      borderColorHover:'yellow'
				    },
				    image:{
				      source:$('#img-profile-source').attr('src'),
				      width:$('#img-profile-source').width,
				      height:$('#img-profile-source').height,
				      minZoom: 50,
				      onRotate: function(imageObject, rotate_angle) {
				        // Get rotatation angle
				        $("#rotation_angle").val(rotate_angle);
				      },
				      onZoom: function(imageObject, dimensions) {
				        // Get zoom coordinates
				        $('#zoom_w').val(dimensions.w);
				        $('#zoom_h').val(dimensions.h);
				        $('#zoom_x').val(dimensions.posX);
				        $('#zoom_y').val(dimensions.posY);
				        // Set drag coordinates to zero when image is zoomed
				        $('#drag_x').val(0);
				        $('#drag_y').val(0);
				      },
				      onImageDrag: function(imageObject, position){
				        // Get dragged image coordinates
				        $('#drag_x').val(position.posX);
				        $('#drag_y').val(position.posY);
				        // Set zoom x-y coordinates to zero when image is dragged
				        $('#zoom_x').val(0);
				        $('#zoom_y').val(0);
				      }
				    }
				  });
			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	$("#avatar-upload").change(function(){
		// $('#img-profile-source').removeClass('hidden');
		readURL(this);
	});
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);