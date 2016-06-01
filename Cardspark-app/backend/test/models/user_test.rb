require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should not save user without an email" do
    user = User.new
    
    assert_not user.save, "User should not be saved without an email"
  end
  
  test "should not allow duplicate users" do
    duplicateUser = User.new(email: "test@email.com")
    
    # User with same email is present in fixture
    assert_not duplicateUser.save, "User should not be saved if duplicate exists"
  end
  
end
