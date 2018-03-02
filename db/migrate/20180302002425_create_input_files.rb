class CreateInputFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :input_files do |t|

      t.timestamps
    end
  end
end
