class CreateScanners < ActiveRecord::Migration[5.1]
  def change
    create_table :scanners do |t|
      t.references :input_file, foreign_key: true
      t.integer :progress, default: 0
    end
  end
end
