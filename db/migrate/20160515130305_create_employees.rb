class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.date :date_of_birth
      t.string :location
      t.integer :phone_number

      t.timestamps null: false
    end
  end
end
