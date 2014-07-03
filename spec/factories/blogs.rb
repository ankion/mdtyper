# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
    user_id 1
    title "MyString"
    subtitle "MyString"
    description "MyText"
  end
end
