class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string   :name
      t.string   :entity_type
      t.string   :jurisdiction_code
      t.string   :date_of_birth
      t.string   :address
      t.string   :company_number

      t.timestamps
    end
  end
end
