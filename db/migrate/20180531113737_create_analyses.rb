class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses do |t|

      t.timestamps
    end
  end
end
