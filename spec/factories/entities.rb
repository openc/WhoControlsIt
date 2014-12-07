FactoryGirl.define do
  factory :entity do

    factory :company_entity do
      sequence(:name) { |n| "Company #{n}"}
      entity_type 'Company'
      jurisdiction "gb"
    end

    factory :person_entity do
      sequence(:name) { |n| "Person #{n}"}
      entity_type 'Person'
    end
  end

end
