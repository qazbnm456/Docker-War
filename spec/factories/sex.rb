FactoryGirl.define do
  factory :sex do
    name ""
  end

  factory :sex_male, parent: :sex do
    name "Male"
  end

  factory :sex_female, parent: :sex do
    name "Female"
  end

  factory :sex_other, parent: :sex do
    name "Other"
  end
end