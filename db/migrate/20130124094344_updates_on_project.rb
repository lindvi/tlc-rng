class UpdatesOnProject < ActiveRecord::Migration
  def up
  	add_column :projects, :increment_size, :integer, default: 0
  	add_column :projects, :hash, :string, default: ""
  end

  def down
  end
end
