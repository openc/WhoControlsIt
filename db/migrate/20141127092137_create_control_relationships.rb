class CreateControlRelationships < ActiveRecord::Migration
  def change
    create_table :control_relationships do |t|
      t.integer :company_id
      t.integer :person_id
      t.string :relationship_type
      t.text :details
      t.string :timestamps

      t.timestamps
    end
  end
end
