class MakeRelationshipsPolymorphic < ActiveRecord::Migration
  def change
    rename_column(:control_relationships, :person_id, :parent_id)
    rename_column(:control_relationships, :company_id, :child_id)
    add_column(:control_relationships, :parent_type, :string)
    add_column(:control_relationships, :child_type, :string)
  end
end
