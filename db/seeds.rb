# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Entity.delete_all
ControlRelationship.delete_all

# seeds_data = YAML.loadfile('seeds.yaml')

mal = Entity.create({name: "Monsoon Accessorize Limited",
                      jurisdiction: "gb",
                      company_number: "01098034",
                      entity_type: 'Company'})
mhl = Entity.create({name: "Monsoon Holdings Ltd",
                      jurisdiction: "gb",
                      company_number: "01098034",
                      entity_type: 'Company'})
ps = Entity.create({  name: 'Peter Michael Simon',
                      date_of_birth: "1949-08-01",
                      address: "15 CHEYNE ROW, LONDON SW3 5TW",
                      entity_type: 'Person'})
ct = Entity.create({  name: 'Chris Taggart',
                      date_of_birth: "1964-04-01",
                      address: "Aston House, Cornwall Avenue, London N3 1LF",
                      entity_type: 'Person',
                      jurisdiction: 'British'})
chr = Entity.create({ name: 'Chrinon Ltd',
                      jurisdiction: "gb",
                      company_number: "07444723",
                      entity_type: 'Company'})

ControlRelationship.create([
  {parent: mhl, child: mal, relationship_type: "Shareholding", details: "100"}
])
ControlRelationship.create([
  {parent: ps, child: mhl, relationship_type: "Trust Beneficiary"}
])
ControlRelationship.create([
  {parent: ct, child: chr, relationship_type: "Shareholding", details: "90"}
])
