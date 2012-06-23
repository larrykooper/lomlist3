# A Tag is a label used to categorize an item.
# An item may have many tags.
class Tag < ActiveRecord::Base
  attr_accessible :name, :user
  has_many :taggings
  has_many :items, :through => :taggings
  belongs_to :user
  
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
  
  def self.used_tags(user)
    Tag.joins(:taggings).select("distinct tags.id, tags.name, LOWER(tags.name)").where("tags.user_id = ?", user.id).order("LOWER(tags.name)") 
  end
  
  def self.unused_tags(user)
    find_by_sql(["SELECT id, name FROM tags WHERE user_id = ? AND id NOT IN (SELECT tag_id FROM taggings) ORDER BY LOWER(name)", user.id])
  end

  def add_item_manually(item, user)
    Tagging.create(:tag => self, :item => item, :user => user)
  end
  
  def items_count
    self.taggings.count
  end

end