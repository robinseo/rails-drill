class CreateHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :hosts do |t|
      t.integer :host_id
      t.string :host_name

      t.timestamps
    end
  end
end
