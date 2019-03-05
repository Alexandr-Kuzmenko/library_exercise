class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  storage :file if Rails.env.development? || Rails.env.test?
  storage :fog if Rails.env.production?

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

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  def extension_whitelist
    %w[jpg jpeg png]
  end

  def size_range
  0..5.megabytes
  end

  def filename
    'avatar.jpg' if original_filename
  end

  private

  def default_avatar_resolution(width, height)
    manipulate! do |img|
      img.combine_options do |c|
        c.fuzz '3%'
        c.trim
        c.resize "#{width}x#{height}>"
        c.resize "#{width}x#{height}<"
      end
      img
    end
  end

  process default_avatar_resolution: [100, 100]
end
