class CreateInputFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :input_files do |t|
      t.binary :data, limit: 20.megabyte
      t.string :content_type
      t.string :name
      t.references :analysis, foreign_key: true
    end
  end
end
