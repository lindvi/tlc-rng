class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :remember_token
      t.string :email
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
