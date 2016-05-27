class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :topic_id
      t.string :file

      t.timestamps null: false
    end
  end
end
