FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:emailccc) { |n| "person_ccc_#{n}@example.com" }
    sequence(:licence) { |n| "%010d" % n }
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end