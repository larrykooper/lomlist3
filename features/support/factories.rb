require 'factory_girl'

FactoryGirl.define do 
  factory :user do
    email 'bob@example.com'
    password 'secret'
  end
end