class StaticPagesController < ApplicationController
  def home
		# 11.45 Adding a feed instance variable to the home action
		if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
   # replaced @micropost = current_user.microposts.build if logged_in? because feed also depends on logged in user, so taking conditional from the end of t			he line and making it for both instance variables
	 # 11.38 Adding a micropost instance variable to the home action
  end

  def help
  end

	def about
	end

	def contact
	end

end
