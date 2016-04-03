class User < ActiveRecord::Base
	#before_save method User.email = downcase 
	before_save { self.email = email.downcase }
	#validations for :name attribute
	validates :name,  presence: true, length: { maximum: 50 }
	
	# REGEX for emails
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#validations for :email attribute
	validates :email, presence: true, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: {case_sensitive: false}

	# has_secure_password method 6.3.1
	has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
