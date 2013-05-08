class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  before_save {|user| user.email = user.email.downcase }
  before_save :create_remember_token

  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: :followed_id, dependent: :destroy, class_name: :Relationship
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(user)
    relationships.find_by_followed_id user.id
  end

  def follow!(user)
    relationships.create! followed_id: user.id
  end

  def unfollow!(user)
    relationships.find_by_followed_id(user.id).destroy
  end
  
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
