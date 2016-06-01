require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "new_user@email.com" }
    end
  end
  
end
