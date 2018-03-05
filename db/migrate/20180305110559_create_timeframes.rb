class CreateTimeframes < ActiveRecord::Migration[5.1]
  def change
    create_table :timeframes do |t|

      t.timestamps
    end
  end
end
