class TopicsController < ApplicationController
  include ApplicationHelper
  
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json

	def index
    user = User.find_by_email(params[:email])
    if user
      @topics = user.topics
      render_object @topics
    else
      render_not_present
    end
	end

  def create
    topic = Topic.new(topic_params)
    user = User.find_by_email(params[:email])
    if user
      if topic.save
        user.topics << topic
        user.save!
        render_id topic
      else
        render_error topic
      end
    else
      render_not_present
    end
  end
  
  def add_viewer
    user = User.find_by_email(params[:email])
    if user
      topic = Topic.find(params[:topic_id])
      if topic
        topic.users << user
        topic.save!
        render_no_content
      else
        render_error topic
      end
    else
      render_not_present
    end
  end

  def update
    topic = Topic.find(params[:topic_id])
    if topic
      if topic.update(topic_params)
        render_no_content
      else
        render_error topic
      end      
    else
      render_error topic
    end
  end

  def destroy
    topic = Topic.find(params[:topic_id])
    if topic
      user = topic.users.find_by_email(params[:email])
      topic.users.delete(user) if user
      
      topic.destroy if topic.users.count == 0
      render_no_content
    else
      render_error topic
    end
  end

private
  def topic_params
    params.require(:topic).permit(:name)
  end

end