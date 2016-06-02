class TopicsController < ApplicationController
  include ApplicationHelper
  
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json

	def index
		@topics = User.find_by_email(params[:user_email]).topics
  	render_instance @topics
	end

  def create
    @topic = Topic.new(topic_params)
    user = User.find_by_email(params[:user_email])
    if @topic.save
      user.topics << @topic
      user.save!
      render :json => { id: @topic.id, object: @topic, status: :created }
    else
      render_error @topic
    end
  end
  
  def add_viewer
    @user = User.find_by_email(params[:email])
    topic = Topic.find(params[:id])
    if @user
      topic.users << @user
      topic.save!
      render_instance @user
    else
      render_error @user
    end
  end

#   def update
#     @topic = Topic.find(params[:id])
#     user = User.find(params[:user_id])
#     user.topics << @topic
#     user.save!  
#     if @topic.update(topic_params)
#       redirect_to @topic
#     else
#       render 'edit'
#     end
#   end

#   def destroy
# 	  @topic = Topic.find(params[:id])
# 	  @topic.destroy
# 	  redirect_to topics_path
# 	end

#   def tcards 
#     @cards = Card.where(topic_id: params[:id])
#     render :nothing => true
#   end

private
  def topic_params
    params.require(:topic).permit(:name)
  end

end
