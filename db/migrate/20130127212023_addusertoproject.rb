class Addusertoproject < ActiveRecord::Migration
  def up
  	add_column :projects, :user_id, :integer
  end

  def down
  end
end
