var ready;
ready = function() {
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
	    source:$('#img-preview').attr('src'),
	    width:$('#img-preview').width,
	    height:$('#img-preview').height,
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

//=require jquery-ui-1.10.3.custom.min
//=require jquery-ui-1.10.3

var cropbuttonclick = function() {
	
	console.log("crop button clicked!")

  var get_html = $('#infoSelector').html();
  var get_array = get_html.split('|');
  var get_x_y_coords_array = get_array[0].split('-');
  var get_w_h_coords_array = get_array[1].split('-');
  var get_x_coord = get_x_y_coords_array[0].split(':')[1];
  var get_y_coord = get_x_y_coords_array[1].split(':')[1];
  var get_w_coord = get_w_h_coords_array[0].split(':')[1];
  var get_h_coord = get_w_h_coords_array[1].split(':')[1];
  $('#crop_x').val(get_x_coord);
  $('#crop_y').val(get_y_coord);
  $('#crop_w').val(get_w_coord);
  $('#crop_h').val(get_h_coord);
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
