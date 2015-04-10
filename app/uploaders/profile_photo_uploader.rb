# encoding: utf-8
class ProfilePhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  include CarrierWave::MiniMagick
  process resize_to_fit: [400, 400]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def default_url
    "default_images/" + [version_name, "profile_default.png"].compact.join("_")
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
