class LogUserpoints < ActiveRecord::Migration
  def change
    create_table :log_userpoints do |t|
      t.integer :log_id
      t.integer :userpoint_id
    end
  end
end
