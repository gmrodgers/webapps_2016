class Card < ActiveRecord::Base
    belongs_to :topic
    validates_presence_of :topic_id
    validates_presence_of :file_location
    validates_numericality_of :topic_id
end
