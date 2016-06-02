require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  
  def setup
    self.use_instantiated_fixtures = true
  end
  
  test "should list all topics belonging to particular user" do
    #user and topics defined in fixture
    get :index, user_email: users(:user).email
    
    assert_response :success
    assert_not_nil assigns(:topics)
  end
  
  test "should create new topic, relation to user and return topic_id" do
    @topic = Topic.new(name: "new_topic")
    assert_difference('Topic.count') do
      assert_difference('users(:user).topics.count') do
        post :create, topic: { name: @topic.name }, user_email: users(:user).email
      end
    end
    value = JSON.parse(@response.body)
    assert_not_nil value['id']
    assert_equal "created", value['status']
  end
  
  test "should add relation between user and topic in association records" do
    assert_difference('topics(:topic2).users.count') do
      assert_difference('users(:viewer_user).topics.count') do
        post :add_viewer, email: users(:viewer_user).email, id: topics(:topic2).id
      end
    end
  end
  
  # test "should update topic name" do
  #   id = 
  #   put :update, user_email: users(:user).email, 
  #   assert_equal "new_title", topics(:topic1).name, 
  # end
  
end
