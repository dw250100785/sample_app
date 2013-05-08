class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:sucess] = "welcome to SAMPLE APP"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private


end
