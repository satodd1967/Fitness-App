class Logs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :worked_out
      t.integer :tracked_food
      t.integer :weight
      t.real :body_fat
      t.integer :active_calories
      t.integer :calories
      t.integer :user_id
    end
  end
end
