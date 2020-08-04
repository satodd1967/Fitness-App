class Points < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :points_worked_out
      t.integer :points_tracked_food
      t.integer :points_met_calorie_goal
      t.integer :points_maintain_weight
      t.integer :points_maintain_bodyfat
      t.integer :points_met_active_calories
    end
  end
end
