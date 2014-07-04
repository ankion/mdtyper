# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    blog_id nil
    publish_date "2014-07-04"
    title "MyString"
    content "MyText"
  end
end
