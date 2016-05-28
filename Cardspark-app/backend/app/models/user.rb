class User < ActiveRecord::Base
  validates :email, presence: true
  validates :password_hash, presence: true
	has_and_belongs_to_many :topics
end
