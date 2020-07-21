class Goals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.float :weight_goal
      t.float :body_fat_goal
      t.integer :start_calorie_goal
      t.integer :user_id
    end
  end
end
