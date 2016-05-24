class UserTopic < ActiveRecord::Migration
  def change
      create_table :user_topic, :id => false do |t|
          t.integer :user_id
          t.integer :topic_id
      end
  end
end
