require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  test "should not save topic without name" do
	  topic = Topic.new
	  assert_not topic.save
  end

  test "should save topic with name" do
	  topic = Topic.new(name: "os")
	  assert topic.save
  end

end
