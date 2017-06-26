var ready;
ready = function() {

	var canvasWidth = 500.0;
	var canvasHeight = 500.0;
	if (window.innerWidth < 500) {
		canvasWidth = 260.0;
		canvasHeight = 260.0;
	}
	if (document.getElementById("myCanvas") !== null ) {
		document.getElementById("myCanvas").width = canvasWidth;
	}

	if (document.getElementById("myCanvas") !== null ) {
		document.getElementById("myCanvas").height = canvasHeight;
	}
	
	var cropzoom = $('#crop_container').cropzoom({ 
	  width:canvasWidth,
	  height:canvasHeight,
	  bgColor: '#CCC',
	  enableRotation:true,
	  enableZoom:false,
	  zoomSteps:10,
	  rotationSteps:10,
	  selector:{
	  	w: 150,
        h: 150,
	    centered:true,
	    startWithOverlay: true,
	    borderColor:'blue',
	    borderColorHover:'yellow'
	  },
	  image:{
	    source:$('#img-profile-source').attr('src'),
	    width:$('#img-profile-source').width,
	    height:$('#img-profile-source').height,
	    minZoom: 50 ,
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

  var get_html = $('#infoSelector').html();
  
  var get_array = get_html.split('|');
  console.log(get_html);
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

  var angle = $("#rotation_angle").val();

  var crop_container = document.getElementById("crop_container");
  var c = document.getElementById("myCanvas");
  var ctx = c.getContext("2d");
  var img = document.getElementById("img-profile-source");
  
  var widthRatio = (crop_container.offsetWidth / img.width);
  var heightRatio = (crop_container.offsetHeight / img.height);
  var aspectRatio = widthRatio;

  if(heightRatio < widthRatio)
  	aspectRatio = heightRatio;

  var tsx = $('#crop_x').val().replace("px", "") / aspectRatio;
  var tsy = $('#crop_y').val().replace("px", "") / aspectRatio;
    
  var sw = $('#crop_w').val().replace("px", "") / aspectRatio;
  var sh = $('#crop_h').val().replace("px", "") / aspectRatio;
  //get the center of the circle
  tsx += sw / 2;
  tsy += sh / 2;

	//get the offset
  tsx -= img.width / 2;
  tsy -= img.height / 2;
  tsy = -tsy;
  var sx = tsx * Math.cos(angle * -1 *  Math.PI / 180) + tsy * Math.sin(angle * -1 * Math.PI / 180);
  var sy = -tsx * Math.sin(angle * -1 * Math.PI / 180) + tsy * Math.cos(angle * -1 * Math.PI / 180);
  sy = -sy;
 

  c.width = crop_container.offsetWidth; c.height = crop_container.offsetHeight;
  ctx.clearRect(0, 0, c.width, c.height);
  //-drawing image
  ctx.save(); 
 
  ctx.scale(aspectRatio, aspectRatio);
  console.log(widthRatio);
  ctx.translate(img.width / 2, img.height / 2);
  ctx.rotate(angle * Math.PI / 180);
	
  ctx.beginPath();
  ctx.arc(0, 0, sw / 2, 0, 2 * Math.PI);
  ctx.strokeStyle = 'rgba(0,0,0,0)';
  ctx.stroke();
  ctx.clip();

  ctx.drawImage(img, sx + img.width / 2 - sw / 2, sy + img.height / 2 - sw / 2, sw, sw, -sw / 2, -sw / 2, sw, sw);
  ctx.restore();

  var ImageData = ctx.getImageData(img.width * aspectRatio / 2 - sw * aspectRatio / 2, img.height * aspectRatio / 2 - sw * aspectRatio / 2, sw * aspectRatio, sw * aspectRatio);

  c.width = sw * aspectRatio;
  c.height = sw * aspectRatio;
  ctx.putImageData(ImageData, 0, 0);

  var myImage = c.toDataURL("image/png");
  var croppedImage = document.getElementById("croppedimage");
  croppedImage.src = myImage;

  c.width = crop_container.offsetWidth; c.height = crop_container.offsetHeight;
  document.getElementById('zoom_w').value = Math.floor(img.width * aspectRatio);
  document.getElementById('zoom_h').value = Math.floor(img.height * aspectRatio);

  console.log(document.getElementById('zoom_w').value);
  console.log(document.getElementById('zoom_h').value);
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);
