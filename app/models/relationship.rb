class Relationship < ActiveRecord::Base
	# 12.3: Adding the follower belongs_to association to the Relationship model
	# belongs to and has many give rise to the methods seen in 12.1 (table summary of association methods like "active_relationship.follower")
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
	# 12.5 Adding the Relationship model validations
	validates :follower_id, presence: true
  validates :followed_id, presence: true
end
