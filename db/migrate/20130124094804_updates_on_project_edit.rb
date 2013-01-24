class UpdatesOnProjectEdit < ActiveRecord::Migration
  def up
  	rename_column :projects, :hash, :project_hash
  end

  def down
  end
end
