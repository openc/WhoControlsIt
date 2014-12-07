FactoryGirl.define do
  factory :control_relationship do
    association :child, factory: :company_entity
    association :parent, factory: :person_entity
  end

end
