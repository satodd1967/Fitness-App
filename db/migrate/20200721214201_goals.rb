class Goals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.real :weight_goal
      t.real :body_fat_goal
      t.integer :start_calorie_goal
      t.integer :user_id
    end
  end
end
