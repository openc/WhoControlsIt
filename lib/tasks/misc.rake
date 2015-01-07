require 'csv'
task :convert_congo_bo_data => :environment do
  # this has been cut and pasted from console and may not work exactly
  f=File.new(Rails.root.join('db','seeds','2 - sociétés minière.csv'))
  rows = CSV.parse(f.read)
  last_co = nil
  last_co_index = nil
  yaml_data = rows.collect.with_index do |r,i|
    new_block = last_co != r[0]
    last_co,last_co_index = [r[0],i+1] if new_block
    entity_data =
      if new_block
        {:name=>r[0].strip, :entity_type=>'Company', :jurisdiction => 'cd'}
      else
        { :name=> r[2], :relationship_type=>'Shareholding',  :entity_type=>'Company', :details=>r[3], :child=>last_co_index, :notes=> (r[4].to_s[/N\/[AC]/] ? nil : r[4])
        }
      end
    [i+1,entity_data]
  end.to_yaml
  File.open(Rails.root.join('db','seeds', 'drc_bo.yml'),'w') { |f| f.puts yaml_data }
  puts "All done. You will now need to correct entity_types, as all are currently denoted as Company"
end