class CreateNeighbourhoods < ActiveRecord::Migration[7.1]
  def change
    create_table :neighbourhoods do |t|
      t.string :name
      t.references :neighbourhood_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
