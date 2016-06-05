class CardsController < ApplicationController
  include ApplicationHelper
  
  skip_before_filter  :verify_authenticity_token
  
	respond_to :json

	def index
	  topic = Topic.find(params[:topic_id])
	  @cards = topic.cards
		render_instance @cards
	end

  def create
    topic = Topic.find(params[:topic_id])
    @card = Card.new(card_params)
    if @card.save
      topic.cards << @card
      topic.save!
      render :json => { id: @card.id, object: @card, status: :created }
    else
      render_error @card
    end
  end

  def show
    topic = Topic.find(params[:topic_id])
    @card = topic.cards.find(params[:id])
  	render_instance @card
  end

  def update
    topic = Topic.find(params[:topic_id])
    @card = topic.cards.find(params[:id])
    if @card.update(card_params)
      render_instance @card
    else
      render_error @card
    end
  end
  
  # def download
  #   send_data(@card.card_file,
  #         type: @card.content_type,
  #         filename: @card.filename)
  # end

  def destroy
    topic = Topic.find(params[:topic_id])
    @card = topic.cards.find(params[:id])
    @card.destroy
   
    render_instance @card
  end

private
  def card_params
    params.require(:card).permit(:topic_id, :cardname, :card_file)
  end
end
