class AddStartAndEndToTimeframe < ActiveRecord::Migration[5.1]
  def change
    add_column :timeframes, :t_start, :datetime
    add_column :timeframes, :t_end, :datetime
  end
end
