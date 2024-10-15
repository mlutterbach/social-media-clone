class AddRetweetIdAndRemoveReplyPrivacyAndLocationToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :retweet_id, :integer
    remove_column :tweets, :reply_privacy
    remove_column :tweets, :location
  end
end
