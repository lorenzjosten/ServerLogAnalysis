class AddTimeframeAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :timeframes, :start_date, :date, default: DateTime.new.to_date
    add_column :timeframes, :start_time, :time, default: DateTime.new.to_time
    add_column :timeframes, :end_date, :date, default: DateTime.new.to_date
    add_column :timeframes, :end_time, :time, default: DateTime.new.to_time
  end
end
