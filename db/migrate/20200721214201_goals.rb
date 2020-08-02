class Goals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.float :start_weight
      t.float :start_bodyfat
      t.float :weight_goal
      t.float :body_fat_goal
      t.integer :start_calorie_goal
      t.integer :user_id
    end
  end
end
