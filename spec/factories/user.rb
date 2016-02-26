FactoryGirl.define do
  factory :user do
    name "admin"
    sequence(:email) { |n| "user#{n}@docker-war.com" }
    password "thisisfortesting"
    admin "f"
    sequence(:port) { |n| n }
    sex do
      Sex.first
    end
  end

  factory :admin, parent: :user do
    admin "t"
  end
end