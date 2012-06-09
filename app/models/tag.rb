# A Tag is a label used to categorize an item.
# An item may have many tags.
class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings
  has_many :items, :through => :taggings
  
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
  
  def self.used_tags
    Tag.joins(:taggings).select("distinct tags.id, tags.name, LOWER(tags.name)").order("LOWER(tags.name)")
  end
  
  def self.unused_tags
    find_by_sql("select id, name from tags " +
    "where id not in (select tag_id from taggings) " +
    "order by LOWER(name)")
  end

  def add_item_manually(item)
    Tagging.create(:tag => self, :item => item)
  end
  
  def items_count
    self.taggings.count
  end

end