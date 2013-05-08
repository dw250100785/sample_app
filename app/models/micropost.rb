class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  
  default_scope order: "microposts.created_at DESC"
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    others = "SELECT followed_id FROM relationships WHERE follower_id = :me"
    where "user_id IN (#{others}) OR user_id = :me", me: user.id
  end
end
