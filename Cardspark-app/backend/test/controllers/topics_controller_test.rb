require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  
  test "should list all topics belonging to particular user" do
    #user and topics defined in fixture
    self.use_instantiated_fixtures = true
    get :index, user_email: users(:user).email
    assert_response :success
    assert_not_nil assigns(:topics)
  end
  
end
