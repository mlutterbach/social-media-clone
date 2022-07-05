class RemoveDateFromTweets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tweets, :date, :datetime
  end
end
