class AddDocumentToControlRelationships < ActiveRecord::Migration
  def change
    add_column :control_relationships, :document, :string
  end
end
