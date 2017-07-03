var ready;
ready = function() {

	// Preview Image Before Upload
	function readURL(input) {

		if (input.files && input.files[0]) {

			var reader = new FileReader();
			var reader1 = new FileReader();

			var orientation = 10;

			reader1.onload = function (e) {				

			    var view = new DataView(e.target.result);

			    if (view.getUint16(0, false) != 0xFFD8) orientation = -2;
			    var length = view.byteLength, offset = 2;
			    while (offset < length) 
			    {
			      var marker = view.getUint16(offset, false);
			      offset += 2;
			      if (marker == 0xFFE1) 
			      {
			        if (view.getUint32(offset += 2, false) != 0x45786966) orientation = -1;
			        var little = view.getUint16(offset += 6, false) == 0x4949;
			        offset += view.getUint32(offset + 4, little);
			        var tags = view.getUint16(offset, little);
			        offset += 2;
			        for (var i = 0; i < tags; i++)
			          if (view.getUint16(offset + (i * 12), little) == 0x0112)
			            {
			            	//return callback(view.getUint16(offset + (i * 12) + 8, little));
			            	orientation = view.getUint16(offset + (i * 12) + 8, little);
			            	break;
			            }
			        
			      }
			      else if ((marker & 0xFF00) != 0xFF00) break;
			      else offset += view.getUint16(offset, false);
			    }
			    if(offset == length) orientation = -1;
			    console.log('abc', orientation);
			    $('#img-profile-source-tmp').attr('alt', orientation);

			// correct the orientation
			//$('#img-profile-source').attr('alt', orientation);
			//console.log(orientation);

			  //end correction
			}			
			reader1.readAsArrayBuffer(input.files[0]);

			reader.onload = function (e) {

				$("#rotation_angle").val(0);
				$('#img-profile-source-tmp').attr('src', e.target.result)
				//if ($('#img-profile-source-tmp').attr('src', e.target.result)) {
					var c = document.getElementById("myCanvasOrientationFix");
					var ctx = c.getContext("2d");
					var imgtmp = document.getElementById("img-profile-source-tmp");				

					imgtmp.onload = function() {
				        var width = this.width;
						var height = this.height;
				        console.log("onload tmp width is : ", width);
				 		console.log("onload tmp height is : ", height);
				 		var orientation = $('#img-profile-source-tmp').attr('alt');

						var myCanvas = document.getElementById("myCanvas");
						var canvasWidth = myCanvas.width;
						var canvasHeight = myCanvas.height;
						console.log("canvas width is : ", width);
					 	console.log("canvas height is : ", height);
						
					 	var widthRatio = canvasWidth / width;
					 	var heightRatio = canvasWidth / height;
					 	var aspectRatio = widthRatio;
					 	if(aspectRatio > heightRatio)
					 		aspectRatio = heightRatio;

						c.width = width * aspectRatio; c.height = height * aspectRatio;
					 	console.log("width is : ", c.width);
					 	console.log("height is : ", c.height);
					 	if(orientation >= 5 && orientation <= 8)
					 	{
					 		c.width = height * aspectRatio;
					 		c.height = width * aspectRatio;
					 	}

					 	console.log("A width is : ", c.width);
					 	console.log("A height is : ", c.height);
						
					 	ctx.save();
						switch (orientation) {
					      case '2': ctx.transform(-1, 0, 0, 1, width * aspectRatio, 0); break;
					      case '3': ctx.transform(-1, 0, 0, -1, width * aspectRatio , height * aspectRatio); break;
					      case '4': ctx.transform(1, 0, 0, -1, 0, height * aspectRatio); break;
					      case '5': ctx.transform(0, 1, 1, 0, 0, 0); break;
					      case '6': ctx.transform(0, 1, -1, 0, height * aspectRatio, 0); break;
					      case '7': ctx.transform(0, -1, -1, 0, height * aspectRatio, width * aspectRatio); break;
					      case '8': ctx.transform(0, -1, 1, 0, 0, width * aspectRatio); break;
					      default: ctx.transform(1, 0, 0, 1, 0, 0);
					    }
					
					 	ctx.drawImage(imgtmp, 0, 0, width, height, 0, 0, width * aspectRatio, height * aspectRatio);
						ctx.restore();
					 	var img = document.getElementById("img-profile-source");
					 	img.src = c.toDataURL();

						console.log("real c.height:  ", c.height);
						myCanvas.height = myCanvas.width / c.width * c.height;

						var selectorWidth = 150;
						if(myCanvas.width > myCanvas.height)
						  selectorWidth = myCanvas.height - 40
						else
						  selectorWidth = myCanvas.width - 40;

						var cropzoom = $('#crop_container').cropzoom({ 
						    width: document.getElementById("myCanvas").width,
						    height:document.getElementById("myCanvas").height,
						    bgColor: '#CCC',
						    enableRotation:true,
						    enableZoom:false,
						    zoomSteps:10,
						    rotationSteps:10,
						    selector:{
						    	w: selectorWidth,
		        				h: selectorWidth,
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
				    };
					
					
				//}
				

			}
			reader.readAsDataURL(input.files[0]);
//			console.log('abc', orientation);
		}
	}

	$("#avatar-upload").change(function(){

		// $('#img-profile-source').removeClass('hidden');
		readURL(this);
	});
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);