# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Person.delete_all
Company.delete_all
ControlRelationship.delete_all

#people = Person.create()
mal = Company.create({name: "Monsoon Accessorize Limited",
                      jurisdiction_code: "gb",
                      company_number: "01098034"})
mhl = Company.create({name: "Monsoon Holdings Ltd",
                      jurisdiction_code: "gb",
                      company_number: "01098034"})

relationships = ControlRelationship.create([
  {parent: mhl, child: mal, relationship_type: "Shareholding", details: "100"}
])
