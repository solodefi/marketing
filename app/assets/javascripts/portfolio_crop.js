var ready;
ready = function() {
    $('#portfolioimage').cropper({
      ready: function (e) {
    /*    var $clone = $(this).clone().removeClass('cropper-hidden');

        $clone.css({
          display: 'block',
          width: '100%',
          minWidth: 0,
          minHeight: 0,
          maxWidth: 'none',
          maxHeight: 'none'
        });

        $previews.css({
          width: '100%',
          overflow: 'hidden'
        }).html($clone);*/
      },

      crop: function (e) {
  /*      var imageData = $(this).cropper('getImageData');
        var previewAspectRatio = e.width / e.height;

        $previews.each(function () {
          var $preview = $(this);
          var previewWidth = $preview.width();
          var previewHeight = previewWidth / previewAspectRatio;
          var imageScaledRatio = e.width / previewWidth;

          $preview.height(previewHeight).find('img').css({
            width: imageData.naturalWidth / imageScaledRatio,
            height: imageData.naturalHeight / imageScaledRatio,
            marginLeft: -e.x / imageScaledRatio,
            marginTop: -e.y / imageScaledRatio
          });
        });*/
      }
    });
}

$(document).ready(ready);
$(document).on('turbolinks:load', ready);