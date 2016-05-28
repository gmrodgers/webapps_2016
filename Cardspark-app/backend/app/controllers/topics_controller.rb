class TopicsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	respond_to :json

	def index
		@topics = Topic.all
  	render :json => @topics
	end

	def create
    @topic = Topic.new(topic_params)
    respond_to do |format|
      if @topic.save
      	redirect_to @topics
      else
        render 'new'
      end
    end
  end

  def new
  	@topic = Topic.new
  	render :nothing => true	
  end

  def edit
    @topic = Topic.find(params[:id])
    render :nothing => true
  end

  def show
    @topic = Topic.find(params[:id])
  	render :nothing => true
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to @topic
    else
      render 'edit'
    end
  end

  def destroy
	  @topic = Topic.find(params[:id])
	  @topic.destroy
	  redirect_to topics_path
	end

  def tcards 
    @cards = Card.where(topic_id: params[:id])
    render :nothing => true
  end

private
def topic_params
  params.require(:topic).permit(:name)
end

end