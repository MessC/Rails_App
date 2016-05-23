class PasswordResetsController < ApplicationController

	# 10.51 before doing update and edit actions in this controller, we need to run get_user and valid_user private method 
	before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]  
  before_action :check_expiration, only: [:edit, :update] # 10.52 check to see if allowed password reset time expired 


	def new
  end


	# 10.41 A create action for password resets
	def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end


	# 10.51
  def edit
	end

	# 10.52 The update action for password reset
	def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end




	private
		
		# 10.52 
		def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

		# 10.51 gets the user by the email
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 10.51 Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
  	
		# 10.52 Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end


end
