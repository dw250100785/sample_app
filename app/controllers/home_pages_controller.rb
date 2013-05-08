class HomePagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.feed.paginate page: params[:page], per_page: 15
    end
  end
end
