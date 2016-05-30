class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	respond_to :json

	def index
		@users = User.all
  	render :nothing => true
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
  	render :nothing => true	
  end

  def edit
    @user = User.find(params[:id])
    render :nothing => true
  end

  def show
    @user = User.find(params[:id])
  	render :nothing => true
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
    render :nothing => true
  end

  def destroy
	  @user = User.find(params[:id])
	  @user.destroy
	  redirect_to users_path
	end 

  def utopics
    @topics = Topic.select(:topic_id, :name).joins(:users).find(params[:id])
    render :nothing => true 
  end

private
  def user_params
    params.require(:user).permit(:email, :password_hash)
  end
end
