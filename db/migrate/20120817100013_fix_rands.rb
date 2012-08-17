class FixRands < ActiveRecord::Migration
  def up
  	change_column :rands, :used, :boolean, default: false
  end

  def down
  end
end
