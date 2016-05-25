require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "should not create user without email" do
		user = User.new(password_hash: "password")
		assert_not user.save
	end

	test "should not create user without password_hash" do
		user = User.new(email: "john@example.com")
		assert_not user.save
	end

end
