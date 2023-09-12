class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :mo_no
      t.string :address
      t.string :email
      t.string :gender

      t.timestamps
    end
  end
end
