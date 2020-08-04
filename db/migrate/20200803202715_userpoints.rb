class Userpoints < ActiveRecord::Migration
  def change
    create_table :userpoints do |t|
      t.integer :worked_out
      t.integer :tracked_food
      t.integer :met_calorie_goal
      t.integer :maintain_weight
      t.integer :maintain_bodyfat
      t.integer :met_active_calories
      
    end
  end
end
