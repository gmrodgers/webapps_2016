class MessagesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
	respond_to :json

	def index
		@messages = Message.all
  	render :nothing => true
	end

	def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
      	redirect_to @message
      else
        render 'new'
      end
    end
  end

  def new
  	@message = Message.new
  	render :nothing => true	
  end

  def edit
    @message = Message.find(params[:id])
  end

  def show
    @message = Message.find(params[:id])
  	render :nothing => true
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message
    else
      render 'edit'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
   
    redirect_to messages_path
  end

private
  def message_params
    params.require(:message).permit(:topic_id, :user_id, :text)
  end

end
