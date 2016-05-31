class Micropost < ActiveRecord::Base
  belongs_to :user # this was generated with the model's creation To get code like @user.microposts.build to work this had to be added (associated methods
  validates :user_id, presence: true # 11.4: A validation for the micropost’s 
  validates :content, presence: true, length: { maximum: 140 } # 11.7 The Micropost model validations
	default_scope -> { order(created_at: :desc) } # 11.16: Ordering the microposts with default_scope
	mount_uploader :picture, PictureUploader # 11.56: Adding an image to the Micropost model
	validate  :picture_size # 11.61: Adding validations to images


private

		# 11.61: Adding validations to images
		# Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
		end

end
