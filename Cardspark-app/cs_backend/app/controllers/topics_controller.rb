class TopicsController < ApplicationController
    def index
	    @topics = Topic.includes(:users).where('users.id' => params[:user_id])
	    render :nothing => @topics
    end

    def create
    	@topic = Topic.new(topic_params)
    	if @topic.save
		    redirect_to @topic
		  else
		    render 'new'
		  end
    end

	private
	  def topic_params
	    params.require(:topic).permit(:name)
	  end
end
