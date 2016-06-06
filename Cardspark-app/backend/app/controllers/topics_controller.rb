class TopicsController < ApplicationController
  include ApplicationHelper
  
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json

	def index
    user = User.find_by_email(params[:email])
    if user
      @topics = user.topics
      render :json => { topics: @topics }
    else
      render_error user
    end
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
    topic = Topic.find(params[:topic_id])
    if @user
      topic.users << @user
      topic.save!
      render_instance @user
    else
      render_error @user
    end
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      render_instance @topic
    else
      render_error @topic
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    user = @topic.users.find_by_email(params[:user_email])
    @topic.users.delete(user) if user
    
    @topic.destroy if @topic.users.count == 0
    render_instance @topic
  end

private
  def topic_params
    params.require(:topic).permit(:name)
  end
  
private
  def user_params
    params.require(:user).permit(:email)
  end

end