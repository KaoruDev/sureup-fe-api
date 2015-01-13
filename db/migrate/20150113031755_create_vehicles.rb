class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :nickname
      t.string :year
      t.string :make
      t.string :model
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
