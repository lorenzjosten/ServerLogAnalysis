class AddAnalysisToTimeframe < ActiveRecord::Migration[5.1]
  def change
    add_reference :timeframes, :analysis, foreign_key: true
  end
end
