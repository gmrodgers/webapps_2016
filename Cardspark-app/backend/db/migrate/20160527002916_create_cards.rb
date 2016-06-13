class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :topic_id
      t.string :cardname
      t.string :card_data
      t.string :image_loc
      t.string :colour
      t.string :question
      t.string :answer
    end
  end
end
