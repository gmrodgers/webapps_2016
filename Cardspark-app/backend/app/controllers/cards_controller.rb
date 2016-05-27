class CardsController < ApplicationControllerskip_before_filter  :verify_authenticity_token
	respond_to :json

	def index
		@cards = Card.all
  	render :nothing => true
	end

	def create
    @card = Card.new(card_params)
    respond_to do |format|
      if @card.save
      	redirect_to @card
      else
        render 'new'
      end
    end
  end

  def new
  	@card = Card.new
  	render :nothing => true	
  end

  def edit
    @card = Card.find(params[:id])
  end

  def show
    @card = Card.find(params[:id])
  	render :nothing => true
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
  @card = Card.find(params[:id])
  @card.destroy
 
  redirect_to cards_path
end

private
def card_params
  params.require(:card).permit(:name)
end
end
