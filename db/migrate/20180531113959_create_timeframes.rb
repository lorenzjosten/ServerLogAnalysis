class CreateTimeframes < ActiveRecord::Migration[5.1]
  def change
    create_table :timeframes do |t|
      t.datetime :start
      t.date :end
      t.references :analysis, foreign_key: true
    end
  end
end
