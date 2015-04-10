class AddColumnToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :profile_photo, "/images/default_images/thumb_photo.jpg"
  end
end
