class AddNotesToControlRelationship < ActiveRecord::Migration
  def change
    add_column :control_relationships, :notes, :text
  end
end
