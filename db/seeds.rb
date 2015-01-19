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
    if !seed_datum.has_key?(:parent) or !seed_datum.has_key?(:child)
      entities[i] = Entity.create!(seed_datum.except(:parent, :child, :relationship_type, :details, :notes) )
    end
    details = seed_datum[:details]
    # check if it's a number -- and convert to be a hash
    if seed_datum[:relationship_type].to_s[/Shareholding/] && details.to_s[/^[\d\.%]+$/]
      details = {:percentage_owned => details}
    end
    relationships << seed_datum.slice(:parent, :child, :relationship_type, :details, :notes).merge(:entity_index => i, :details => details) if seed_datum[:parent]||seed_datum[:child]
  end

  # ...then iterate through relationships array and create these too
  relationships.each_with_index do |relationship_hash,i|
    child = relationship_hash[:child] ? entities[relationship_hash[:child]] : entities[relationship_hash[:entity_index]]
    parent = relationship_hash[:parent] ? entities[relationship_hash[:parent]] : entities[relationship_hash[:entity_index]]
    ControlRelationship.create!( relationship_hash.except(:entity_index).merge(:child => child, :parent => parent) )
    puts "created relationship: #{parent.name} is parent of #{child.name}"
  end

end
