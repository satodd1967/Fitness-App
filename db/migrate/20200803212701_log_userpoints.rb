class LogUserPoints < ActiveRecord::Migration
  def change
    create_table :song_genres do |t|
      t.integer :log_id
      t.integer :userpoint_id
    end
  end
  end
end
