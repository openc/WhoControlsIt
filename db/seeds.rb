# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Entity.delete_all
ControlRelationship.delete_all

seed_files = Dir.glob(Rails.root.join('db','seeds','*.yml'))

# require 'byebug'

# debugger

seed_files.each do |seed_file|
  seed_data = YAML.load_file(seed_file)

  # first iterate through creating entities, extracting relationships
  entities = {}
  relationships = []
  seed_data.each do |i, seed_datum|
    entities[i] = Entity.create!(seed_datum.except(:parent, :child, :relationship_type, :details, :notes) )
    relationships << seed_datum.slice(:parent, :child, :relationship_type, :details, :notes).merge(:entity_index => i) if seed_datum[:parent]||seed_datum[:child]
  end

  # ...then iterate through relationships array and create these too
  relationships.each_with_index do |relationship_hash,i|
    if relationship_hash[:child]
      child, parent = [entities[relationship_hash[:child]], entities[relationship_hash[:entity_index]]]
    else
      parent, child = [entities[relationship_hash[:parent]], entities[relationship_hash[:entity_index]]]
    end
    relationship_data = relationship_hash.merge(
      :child => entities[i],
      :parent => entities[relationship_hash[:parent]]
      )
    ControlRelationship.create!( relationship_hash.except(:entity_index).merge(:child => child, :parent => parent) )
    puts "created relationship: #{parent.name} is parent of #{child.name}"
  end

end
