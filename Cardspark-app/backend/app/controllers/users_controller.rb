class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json
	
  def create
    @user = User.new(user_params)
    if @user.save
      render :json => @user, status: :created
    else
      render :json => { :errors => @user.errors.full_messages },
                      status: :unprocessable_entity
    end
  end

#   def update
#     @user = User.find(params[:id])
#     if @user.update(user_params)
#       redirect_to @user
#     else
#       render 'edit'
#     end
#     render :json => @user
#   end

#   def destroy
# 	  @user = User.find(params[:id])
# 	  @user.destroy
# 	  redirect_to users_path
# 	end 

#   def utopics
#     @topics = User.find(params[:id]).topics
#     render :json => @topics 
#   end

private 
  def user_params
    params.require(:user).permit(:email)
  end
end
