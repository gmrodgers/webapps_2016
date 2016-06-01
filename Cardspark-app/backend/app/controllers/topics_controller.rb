class TopicsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json

	def index
		@topics = User.find_by_email(params[:user_email]).topics
  	render :json => @topics
	end

# 	def create
#     @topic = Topic.new(topic_params)
#     user = User.find(params[:user_id])
#     user.topics << @topic
#     user.save!  
#     respond_to do |format|
#       if @topic.save
#       	redirect_to @topics
#       else
#         render 'new'
#       end
#     end
#   end

#   def new
#   	@topic = Topic.new
#   	render :nothing => true	
#   end

#   def edit
#     @topic = Topic.find(params[:id])
#     render :nothing => true
#   end

#   def show
#     @topic = Topic.find(params[:id])
#   	render :nothing => true
#   end

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

# private
#   def topic_params
#     params.require(:topic).permit(:name)
#   end

end
