class Card < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :filename, presence: true
  validates :card_file, presence: true
	belongs_to :topic
end
