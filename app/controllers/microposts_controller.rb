class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy] # 11.32: Adding authorization to the Microposts controller actions (with logged_in_user method 	now available (in the base class ( ApplicationController )) We can now restrict access to the create and destroy action methods 
  before_action :correct_user,   only: :destroy # 11.50: The Microposts controller destroy action

	# 11.34: The Microposts controller create action
	def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
			@feed_items = [] # 11.48: Adding an (empty) @feed_items instance variable to the create action to make sure it is clear if a glitch happens I think
      render 'static_pages/home'
    end
  end

	# 11.50
  def destroy
  	@micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
	end

	private

  	def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end

end
