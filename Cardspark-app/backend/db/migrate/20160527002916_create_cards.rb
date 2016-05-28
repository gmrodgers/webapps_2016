class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :topic_id
      t.string :filename
      t.binary :card_file
    end
  end
end
