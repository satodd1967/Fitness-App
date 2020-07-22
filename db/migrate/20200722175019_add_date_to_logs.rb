class AddDateToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :date, :string
  end
end
