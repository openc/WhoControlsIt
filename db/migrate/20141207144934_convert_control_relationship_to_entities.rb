class ConvertControlRelationshipToEntities < ActiveRecord::Migration
  def up
    remove_column :control_relationships, :child_type
    remove_column :control_relationships, :parent_type
    rename_column :entities, :jurisdiction_code, :jurisdiction
  end

  def down
    rename_column :entities, :jurisdiction, :jurisdiction_code
    add_column :control_relationships, :child_type, :string
    add_column :control_relationships, :parent_type, :string
  end
end