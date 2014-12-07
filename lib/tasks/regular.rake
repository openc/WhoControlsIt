desc 'Flush and Regenerate all data in database'
task :regenerate_data => :environment do
  [Company, Person, ControlRelationship].each do |model|
    model.delete_all
  end
  Rake::Task["db:seed"].invoke
end