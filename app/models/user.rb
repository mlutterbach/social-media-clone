class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :comments

  validates_presence_of :description, :name
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def follow(user)
    # return if following?(user) # Prevent duplicate follow
    increment!(:following_count)
    user.increment!(:followers_count)
  end

  def unfollow(user)
    # return unless following?(user) # Prevent unfollowing if not following
    decrement!(:following_count)
    user.decrement!(:followers_count)
  end
end
