# An Act Type is a short code, written in capital letters. It is the broad category for a to-do item.

class ActType < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
end
