class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :jurisdiction_code
      t.string :company_number

      t.timestamps
    end
  end
end
