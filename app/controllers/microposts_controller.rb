class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build params[:micropost]
    if @micropost.save
      flash[:sucess] = "micropost created"
      redirect_to root_path
    else
      @microposts = current_user.feed.paginate page: params[:page], per_page: 15
      render 'home_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to current_user
  end

  private

  def correct_user
    @micropost = current_user.microposts.find_by_id params[:id]
    redirect_to root_path if @micropost.nil?
  end
end
