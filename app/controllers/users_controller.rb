class UsersController < ApplicationController
	
	# filters 
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
																				:following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

	# 9.33 gets all users to show
	def index
		@users = User.paginate(page: params[:page])
	end
	
	#shows a user and in 11.22 we add an @microposts instance variable for the _micropost partial to work
	def show
		@user = User.find(params[:id])	
		@microposts = @user.microposts.paginate(page: params[:page])
	end


	#creates a new user 
  def new
		@user = User.new
	end


	#saves a new user if user passes user_params test else renders to new user page
	def create
		@user = User.new(user_params)		
		if @user.save
			# 10.21 changed 7.4 to redirect to root_url with use of the mailer
      @user.send_activation_email
			flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
		else
			render 'new'
		end
	end



 	def edit
    @user = User.find(params[:id])
  end	



	def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
			#handles succesful update
			flash[:success] = "Profile updated"
    	redirect_to @user
    else
      render 'edit'
    end
  end

	
	# 9.53 uses method chaining to find and destory the user in one line 
	def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

	# 12.25: The following and followers actions
	def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

	
	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Before filters

    # Confirms a logged-in user (moved in 11.31 to the base class Application controller, becuase it is used twice in this project (microposts controller)
    #def logged_in_user
     # unless logged_in?
			#	store_location
       #flash[:danger] = "Please log in."
        #redirect_to login_url
      #end
    #end

		# Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
		end
	
		# 9.54 Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
