class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :followers_count, :integer
    add_column :users, :following_count, :integer
    add_column :users, :description, :string
    add_column :users, :tweets_count, :integer
  end
end
