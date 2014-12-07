class ConvertDateofbirthToDate < ActiveRecord::Migration
  def change
    change_column :people, :date_of_birth, :date
  end
end