class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
    
    # Ensure a user can only like a tweet once
    add_index :likes, [:user_id, :tweet_id], unique: true
  end
end
