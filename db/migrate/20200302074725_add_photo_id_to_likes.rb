class AddPhotoIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :photo_id, :integer
  end
end
