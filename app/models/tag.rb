# A Tag is a label used to categorize an item.
# An item may have many tags.
class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :users, :through => :taggings
  
  # input is a delimited list of tags 
  # output is an array of tags 
  def self.parse(list)
    tag_names = []
    # first, pull out the quoted tags
    list.gsub!(/\"(.*?)\"\s*/ ) { tag_names << $1; "" } 
    # then, replace all commas with a space
    list.gsub!(/,/, " ")
    # then, get whatever's left
    tag_names.concat list.split(/\s/)
    # strip whitespace from the names
    tag_names = tag_names.map { |t| t.strip }
    # delete any blank tag names
    tag_names = tag_names.delete_if { |t| t.empty? }    
    return tag_names
  end  
  
  def add_item_manually(item)    
     Tagging.create(:tag => self, :item => item)    
   end  
  
end
