class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.integer :fan_id 
      t.string :photo_id_integer 

      t.timestamps
    end
  end
end
