class AddAnalysisToInputFile < ActiveRecord::Migration[5.1]
  def change
    add_reference :input_files, :analysis, foreign_key: true
  end
end
