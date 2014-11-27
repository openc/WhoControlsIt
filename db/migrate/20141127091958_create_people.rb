class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :nationality
      t.string :date_of_birth
      t.string :address

      t.timestamps
    end
  end
end
