# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Person.delete_all
Company.delete_all
ControlRelationship.delete_all

# seeds_data = YAML.loadfile('seeds.yaml')

#people = Person.create()
mal = Company.create({name: "Monsoon Accessorize Limited",
                      jurisdiction_code: "gb",
                      company_number: "01098034"})
mhl = Company.create({name: "Monsoon Holdings Ltd",
                      jurisdiction_code: "gb",
                      company_number: "01098034"})
ps = Person.create({name: 'Peter Michael Simon',
                    date_of_birth: "1949-08-04",
                    address: "15 CHEYNE ROW, LONDON SW3 5TW"})

ControlRelationship.create([
  {parent: mhl, child: mal, relationship_type: "Shareholding", details: "100"}
])
ControlRelationship.create([
  {parent: ps, child: mhl, relationship_type: "Trust Beneficiary"}
])
