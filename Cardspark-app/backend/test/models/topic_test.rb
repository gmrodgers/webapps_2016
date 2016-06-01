require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  test "should not save topic without a name" do
    topic = Topic.new
    
    assert_not topic.save, "Topic should not be saved without a name"
  end

end
