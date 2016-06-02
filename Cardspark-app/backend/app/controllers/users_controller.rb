class UsersController < ApplicationController
  include ApplicationHelper
  
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json
	
	# Could have a get_id function which returns a users id in the database.
	# This would be saved in the app and would allow future calls to be made
	# using the id instead of email for lookup.
	
  def create
    @user = User.new(user_params)
    if @user.save
      render_instance @user
    else
      render_error @user
    end
  end

  def update
    @user = User.find_by_email(params[:email])
    if @user.update(user_params)
      render_instance @user
    else
      render_error @user
    end
  end

  def destroy
    @user = User.find_by_email(params[:email])
    if @user.destroy
      render_instance @user
    else
      render_error @user
    end
  end
  
private 
  def user_params
    params.require(:user).permit(:email)
  end
end
