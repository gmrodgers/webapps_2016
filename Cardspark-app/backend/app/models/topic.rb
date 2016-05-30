class Topic < ActiveRecord::Base
  validates :name, presence: true
	has_and_belongs_to_many :users
	has_many :cards
	has_many :messages
end
