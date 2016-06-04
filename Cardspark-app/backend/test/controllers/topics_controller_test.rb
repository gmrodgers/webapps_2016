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
        post :add_viewer, email: users(:viewer_user).email, topic_id: topics(:topic2).id
      end
    end
  end
  
  test "should update topic name" do
    topic = topics(:topic1)
    put :update, id: topic.id, topic: { name: "new_title" }
    assert_equal "new_title", Topic.find(topic.id).name
  end
  
  test "should remove user association with topic" do
    user = users(:user)
    assert_difference('user.topics.count', -1) do
      delete :destroy, user_email: user.email, id: topics(:topic1).id
    end
  end
  
  test "should delete topic when requested and only one user owns the topic" do
    user = users(:user)
    assert_difference('Topic.count', -1) do
      delete :destroy, user_email: user.email, id: topics(:topic2).id
    end
  end
  
  # TODO: Test that all cards are deleted when a topic is deleted
  
end
