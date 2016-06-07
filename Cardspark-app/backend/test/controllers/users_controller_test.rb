require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # should add tests for when params are invalid
  
  test "should create user" do
    assert_difference('User.count') do
      user = User.new(email: "example@email.com")
      post :create, user: { email: user.email }
    end
  end
  
  test "should update user email" do
    user = users(:user)
    put :update, user: { email: "new_user@email.com" }, email: user.email 
    assert_equal "new_user@email.com", User.find(user.id).email
  end
  
  test "should delete user and remove associations with topics" do
    assert_difference('User.count', -1) do
      topic = topics(:topic1)
      assert_difference('topic.users.count', -1) do
        delete :destroy, email: users(:viewer_user).email
      end
    end
  end
  
  test "should delete topic if user to be deleted is the only owner" do
    assert_difference('Topic.count', -2) do
        delete :destroy, email: users(:user).email
    end
  end
  
end
