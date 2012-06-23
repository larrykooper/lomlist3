class Tagging < ActiveRecord::Base
  attr_accessible :tag, :item, :user
  belongs_to :tag
  belongs_to :item
  belongs_to :user 
end