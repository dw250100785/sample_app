class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  before_save {|user| user.email = user.email.downcase }
  before_save :create_remember_token

  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
