class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :topic_id
      t.string :cardname
      t.string :card_data
      # t.string :content_type
      # t.binary :card_file
    end
  end
end
