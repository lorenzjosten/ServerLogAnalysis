class AddAttributesToAccessDatum < ActiveRecord::Migration[5.1]
  def change
    add_column :access_data, :request, :string
    add_column :access_data, :url, :string
    add_column :access_data, :access_time, :datetime
    add_column :access_data, :stat, :string
    add_column :access_data, :respT, :integer
  end
end
