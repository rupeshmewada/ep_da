class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.integer :no

      t.timestamps
    end
  end
end
