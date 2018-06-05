class CreateInputFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :input_files do |t|
      t.binary :data
      t.string :name
      t.string :content_type

      t.timestamps
    end
  end
end
