class ConvertControlRelationshipToEntities < ActiveRecord::Migration
  def up
    remove_column :control_relationships, :child_type
    remove_column :control_relationships, :parent_type
    rename_column :entities, :jurisdiction_code, :jurisdiction
    change_column :entities, :date_of_birth, :date
  end

  def down
    change_column :entities, :date_of_birth, :string
    rename_column :entities, :jurisdiction, :jurisdiction_code
    add_column :control_relationships, :child_type, :string
    add_column :control_relationships, :parent_type, :string
  end
end