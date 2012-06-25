require 'factory_girl'

FactoryGirl.define do 
  factory :user do
    email 'bob@example.com'
    password 'secret'
  end
  
  factory :item do 
    association :user
    number  1
    item_desc  'Test item content'
    create_date Time.now
  end
  
end