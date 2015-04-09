# encoding: utf-8
class AuxPhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  include CarrierWave::MiniMagick
  process resize_to_fit: [400, 400]

  def default_url
    "no image"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
