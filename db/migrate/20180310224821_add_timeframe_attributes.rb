class AddTimeframeAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :timeframes, :start_date, :date
    add_column :timeframes, :start_time, :time
    add_column :timeframes, :end_date, :date
    add_column :timeframes, :end_time, :time
  end
end
