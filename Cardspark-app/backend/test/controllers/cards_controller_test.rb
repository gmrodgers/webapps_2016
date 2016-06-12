require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  
  # def setup
  #   self.use_instantiated_fixtures = true
  # end
  
  test "should list all cards belonging to particular topic" do
    get :index, topic_id: topics(:topic1).id

    assert_response :success
    assert_not_nil assigns(:cards)
  end
  
  test "should create new card" do
    assert_difference('Card.count') do
      topic = topics(:topic1)
      card = Card.new(topic_id: topic.id, cardname: "example", card_data: "binary")
      post :create, card: { topic_id: card.topic_id, cardname: card.cardname, card_data: card.card_data }
    end
  end
  
  test "should update card attributes" do
    card = cards(:card_one)
    put :update, card_id: card.id, card: { cardname: "example" } 
    assert_equal "example", Card.find(card.id).cardname
  end
  
  test "should delete card" do
    assert_difference('Card.count', -1) do
      card = cards(:card_two)
      delete :destroy, card_id: card.id
    end
  end

  test "should get all answers of cards but the given card" do
    card = cards(:card_three)
    topic = topics(:topic1)
    get :get_answers, topic_id: topic.id, card_id: card.id

    assert_response :success
    assert_not_nil assigns(:cards)
    refute(@response.include? card)
  end
  
end
