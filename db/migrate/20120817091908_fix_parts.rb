class FixParts < ActiveRecord::Migration
  def up
  	add_column :parts, :used_rands, :integer, default: 0
  end

  def down
  end
end
