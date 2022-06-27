class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.datetime :date
      t.string :content
      t.integer :retweet_count
      t.integer :likes_count
      t.references :user, null: false, foreign_key: true
      t.boolean :reply_privacy
      t.string :location

      t.timestamps
    end
  end
end
