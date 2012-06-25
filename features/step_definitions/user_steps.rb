Given /^there is a User$/ do 
  FactoryGirl.create(:user)
end 

Given /^an item exists with description "(.*?)"$/ do |item_description|
  User.count.should == 1
  FactoryGirl.create(:item, :item_desc => item_description, :user => User.first)
end