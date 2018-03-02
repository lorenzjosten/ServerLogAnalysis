class AddAttributesToInputFile < ActiveRecord::Migration[5.1]
  def change
    add_column :input_files, :name, :text
    add_column :input_files, :content_type, :string
    add_column :input_files, :data, :binary, :limit => 10.megabyte
  end
end
