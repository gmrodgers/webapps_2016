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
  
  test "should create new topic and relation to user" do
    @topic = Topic.new(name: "new_topic")
    assert_difference('Topic.count') do
      assert_difference('users(:user).topics.count') do
        post :create, topic: { name: @topic.name }, user_email: users(:user).email
      end
    end
  end
  
  test "should add user relation to topic in association records" do
    assert_difference('topics(:topic2).users.count') do
      assert_difference('users(:viewer_user).topics.count') do
        post :add_viewer, email: users(:viewer_user).email, id: topics(:topic2).id
      end
    end
  end
  
end
