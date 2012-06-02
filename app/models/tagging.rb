class Tagging < ActiveRecord::Base
  attr_accessible :tag, :item
  belongs_to :tag
  belongs_to :item
end