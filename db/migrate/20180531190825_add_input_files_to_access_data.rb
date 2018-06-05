class AddInputFilesToAccessData < ActiveRecord::Migration[5.1]
  def change
    add_reference :access_data, :input_file, foreign_key: true
  end
end
