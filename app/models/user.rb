class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :tweets
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :comments
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed

  has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
  has_many :followers, through: :reverse_follows, source: :follower

  validates_presence_of :description, :name
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def following?(user)
    followed_users.include?(user)
  end

  def follow(user)
    unless following?(user)
      follows.create(followed_id: user.id)
      increment!(:following_count)
      user.increment!(:followers_count)
    end
  end

  def unfollow(user)
    if following?(user)
      follows.find_by(followed_id: user.id)&.destroy
      decrement!(:following_count)
      user.decrement!(:followers_count)
    end
  end

  private

  def password_required?
    # Password is required if creating a new user or if the password is being changed
    new_record? || password.present?
  end
end
