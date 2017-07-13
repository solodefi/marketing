class PortfolioUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process :auto_orient

  version :custom_crop do
    process :resize_and_crop
  end

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def auto_orient
    manipulate! do |img|
     img = img.auto_orient
    end
  end

  def resize_and_crop

    if model.class.to_s == "Portfolio"
      if model.crop_x.present?
        puts "crop ddd"
        manipulate! do |img|
          #img.auto_orient!
          #img = yield(img) if block_given?

          w = model.crop_w.to_i
          h = model.crop_h.to_i

          puts "Parameters : "
          puts model.zoom_x
          puts model.zoom_w
          puts model.crop_x
          puts model.crop_y
          puts model.crop_w
          puts model.crop_h
          puts model.rotation_angle
          puts "parameters end"

          c_x = model.crop_x.gsub('px','')
          c_y = model.crop_y.gsub('px','')
          c_w = model.crop_w.gsub('px','')
          c_h = model.crop_h.gsub('px','')

          puts "Parameters : "
          puts model.zoom_x
          puts model.zoom_w
          puts model.crop_x
          puts model.crop_y
          puts model.crop_w
          puts model.crop_h
          puts model.rotation_angle
          puts "parameters end"


          
          # Set x-y coordinates of cropped image.
          x = model.zoom_x.to_i >= 0 ? (c_x.to_i - model.zoom_x.to_i) : (model.zoom_x.to_i.abs + c_x.to_i)
          y = model.zoom_y.to_i >= 0 ? (c_y.to_i - model.zoom_y.to_i) : (model.zoom_y.to_i.abs + c_y.to_i)
          x = model.drag_x.to_i >= 0 ? (x - model.drag_x.to_i) : (model.drag_x.to_i.abs + x)
          y = model.drag_y.to_i >= 0 ? (y - model.drag_y.to_i) : (model.drag_y.to_i.abs + y) 

          # x = (x.to_i * model.zoom_w.to_f).to_s
          # y = (y.to_i * model.zoom_w.to_f).to_s
          # w = (w.to_i * model.zoom_w.to_f).to_s
          # h = (h.to_i * model.zoom_w.to_f).to_s


          img.combine_options do |i|
            # First we need to resize image with zoomed image. For more details you can find here "https://github.com/minimagick/minimagick"
            i.resize "#{model.zoom_w}x#{model.zoom_h}+0+0^\!"
            # i.resize "500x388+0+0^\!"
            # Rotate zoomed image
            i.rotate(model.rotation_angle.to_i)
            # Crop zoomed and rotated image
            i.crop "#{w}x#{h}+#{x}+#{y}"
            # i.crop "#{w}x#{h}+0+0"

            Rails.logger.info "Successfully croped"
          end
          img
        end
      end
    end
  

  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
