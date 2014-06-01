# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  
  # If there are issues with slow tests, uncomment lines below to manually override. Initializer should work though.
  # if Rails.env == 'test'
    # storage :file
  # else
    # storage :fog
  # end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "development/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:

  # If there are issues with slow tests, uncomment line below to manually override. Initializer should work though.
  # unless Rails.env == "test"
    process :resize_to_fit => [622, 622]
    process :convert => 'png'

    # version :large do
    #   process :resize_to_fill => [350,400]
    #   process :convert => 'png'
    # end
  
    # version :medium do
    #   process :resize_to_fill => [150,150]
    #   process :convert => 'png'
    # end
  
    # version :thumb do
    #   process :resize_to_fill => [60,60]
    #   process :convert => 'png'
    # end
  # end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
