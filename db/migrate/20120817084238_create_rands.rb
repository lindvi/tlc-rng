class CreateRands < ActiveRecord::Migration
  def change
    create_table :rands do |t|
      t.integer :part_id
      t.boolean :used

      t.timestamps
    end
  end
end
