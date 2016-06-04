class RelationshipsController < ApplicationController
	# 12.31: Access control for relationships
	before_action :logged_in_user

	# 12.31: Access control for relationships
	# 12.32: The Relationships controller
  # 12.35 Responding to Ajax requests in the Relationships controller
	def create
		@user = User.find(params[:followed_id])
    current_user.follow(@user)
  	respond_to do |format|
    	format.html { redirect_to @user }
    	format.js
    end
	end

	# 12.32: The Relationships controller
  # 12.35: Responding to Ajax requests in the Relationships controller
	def destroy
		@user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  	respond_to do |format|
    	format.html { redirect_to @user }
    	format.js
		end
	end
end
