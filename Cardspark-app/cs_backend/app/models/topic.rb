class Topic < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :cards, dependent: :destroy
    validates_presence_of :name
end
