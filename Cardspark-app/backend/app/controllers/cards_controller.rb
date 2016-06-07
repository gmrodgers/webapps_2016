class CardsController < ApplicationController
  include ApplicationHelper
  
  skip_before_filter  :verify_authenticity_token
	# should check that the above does not lead to security issues
	respond_to :json

	def index
	  topic = Topic.find(params[:topic_id])
	  if topic
  	  @cards = topic.cards
  		render_object @cards	    
	  else
	    render_error topic
	  end
	end

  def create
    topic = Topic.find(params[:topic_id])
    if topic
      card = Card.new(card_params)
      if card.save
        topic.cards << card
        topic.save!
        render_id card
      else
        render_error card
      end      
    else
      render_error topic
    end
  end

  def show
    topic = Topic.find(params[:topic_id])
    @card = topic.cards.find(params[:card_id])
  	render_object @card
  end

  def update
    topic = Topic.find(params[:topic_id])
    card = topic.cards.find(params[:card_id])
    if card.update(card_params)
      render_no_content
    else
      render_error card
    end
  end
  
  # def download
  #   send_data(@card.card_file,
  #         type: @card.content_type,
  #         filename: @card.filename)
  # end

  def destroy
    topic = Topic.find(params[:topic_id])
    card = topic.cards.find(params[:card_id])
    card.destroy
    render_no_content
  end

private
  def card_params
    params.require(:card).permit(:topic_id, :cardname, :card_file)
  end
end
