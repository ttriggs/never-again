class ChangeProfilePhotoDefault < ActiveRecord::Migration
  def up
    change_column_default(:users, :profile_photo, "")
  end

  def down
    change_column_default(:users, :profile_photo, "/images/default_images/thumb_photo.jpg")
  end
end
