require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # should add tests for when params are invalid
   
  def setup
    @user = User.new(email: "example@email.com")
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: @user.email }
    end
  end
  
  test "should update user email" do
    if @user.save
      put :update, user: { email: "new_user@email.com" }, email: @user.email 
      assert_equal "new_user@email.com", User.find(@user.id).email
    end
  end
  
  test "should delete user" do
    assert_no_difference('User.count') do
      post :create, user: { email: @user.email }
      delete :destroy, email: @user.email
    end
  end
  
end
