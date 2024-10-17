class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :content, length: { minimum: 1, maximum: 140 }
end
