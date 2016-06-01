class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json
	
  def create
    @user = User.new(user_params)
    if @user.save
      render_user @user
    else
      render_error @user
    end
  end

  def update
    @user = User.find_by_email(params[:email])
    if @user.update(user_params)
      render_user @user
    else
      render_error @user
    end
  end

  def destroy
    @user = User.find_by_email(params[:email])
    if @user.destroy
      render_user @user
    else
      render_error @user
    end
  end 

#   def utopics
#     @topics = User.find(params[:id]).topics
#     render :json => @topics 
#   end

private 
  def user_params
    params.require(:user).permit(:email)
  end
  
private
  def render_error(user)
    render :json => { :errors => user.errors.full_messages }
  end
  
private
  def render_user(user)
    render :json => user, status: :no_content
  end
end
