class CreateAccessData < ActiveRecord::Migration[5.1]
  def change
    create_table :access_data do |t|

      t.timestamps
    end
  end
end
