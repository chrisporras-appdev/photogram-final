class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :comments_count , :default => 0
      t.integer :likes_count , :default => 0
      t.boolean :is_private
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
