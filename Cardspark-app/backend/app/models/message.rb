class Message < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :user_id, presence: true
  belongs_to :user_id
  belongs_to :group_id
end
