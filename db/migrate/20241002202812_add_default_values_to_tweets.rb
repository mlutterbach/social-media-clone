class AddDefaultValuesToTweets < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tweets, :likes_count, 0
    change_column_default :tweets, :retweet_count, 0
  end
end
