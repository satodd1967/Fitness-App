class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.float :start_weight
      t.float :start_bodyfat
    end
  end
end
