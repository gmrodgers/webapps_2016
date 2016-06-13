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
    card = Card.new(card_params)
    topic = Topic.find(card.topic_id)
    if card.save
      topic.cards << card
      topic.save!
      render_object card
    else
      render_error card
    end
  end

  def update
    card = Card.find(params[:card_id])
    if card.update(card_params)
      render_no_content
    else
      render_error card
    end
  end

  def destroy
    card = Card.find(params[:card_id])
    card.destroy
    render_no_content
  end

private
  def card_params
    params.require(:card).permit(:topic_id, :cardname, :card_data, :image_loc )
  end
end
