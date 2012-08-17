class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :project_id
      t.string :part_name
      t.integer :part_size

      t.timestamps
    end
  end
end
