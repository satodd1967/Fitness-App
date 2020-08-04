class Logs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :worked_out
      t.integer :tracked_food
      t.float :weight
      t.float :body_fat
      t.integer :active_calories
      t.integer :calories
      t.integer :user_id
      t.integer :points_worked_out
      t.integer :points_tracked_food
      t.integer :points_met_calorie_goal
      t.integer :points_maintain_weight
      t.integer :points_maintain_bodyfat
      t.integer :points_met_active_calories
      t.integer :total_points
    end
  end
end
