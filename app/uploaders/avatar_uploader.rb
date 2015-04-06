# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  include CarrierWave::MiniMagick
    process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  def default_url
   "/assets/default_images/" + [version_name, "default_photo.jpg"].compact.join('_')
  end

  uploader = AvatarUploader.new

  uploader.store!(my_file)

  uploader.retrieve_from_store!('my_file.png')
  u = User.new
  u.avatar = params[:file] # Assign a file like this, or
  u.save!
  u.avatar.url # => '/url/to/file.png'
  u.avatar.current_path # => 'path/to/file.png'
  u.avatar.identifier # => 'file.png'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "/public/uploads/user/avatar/#{user.id}/file_name"
  end

  def cache_dir
    '/tmp/projectname-cache'
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
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
