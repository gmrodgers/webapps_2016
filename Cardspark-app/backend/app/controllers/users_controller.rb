class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	respond_to :json

	def index
		@users = User.all
  	render :json => @users
	end

	def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
      	redirect_to @user
      else
        render 'new'
      end
    end
  end

  def new
  	@user = User.new
  	render :json => @user	
  end

  def edit
    @user = User.find(params[:id])
    render :json => @user
  end

  def show
    @user = User.find(params[:id])
  	render :json => @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
    render :json => @user
  end

  def destroy
	  @user = User.find(params[:id])
	  @user.destroy
	  redirect_to users_path
	end 

  def utopics
    @topics = User.find(params[:id]).topics
    render :json => @topics 
  end

private 
  def user_params
    params.require(:user).permit(:email)
  end
end
