class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :email
      t.string :specilization
      t.integer :mo_no
      t.text :location
      t.integer :fees

      t.timestamps
    end
  end
end
