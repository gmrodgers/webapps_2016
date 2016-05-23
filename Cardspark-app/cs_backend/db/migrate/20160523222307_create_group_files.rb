class CreateGroupFiles < ActiveRecord::Migration
  def change
    create_table :group_files do |t|
      t.integer :group_id
      t.string :file_location

      t.timestamps null: false
    end
  end
end
