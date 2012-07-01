gem 'sanitize'

# An item is one item in the user's to do list.
class Item < ActiveRecord::Base
  attr_accessible :act_type, :create_date, :item_desc, :number, :out_indicator, :short_task_name, :swiss_cheese, :value_when_done, :where_to_do, :user
  has_many :taggings, :dependent => :destroy   
  has_many :tags, :through => :taggings, :uniq => true
  belongs_to :user 
  validates :number, :uniqueness => {:scope => :user_id}
  validates :number, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :item_desc, :presence => true  
  before_save :sanitize_input 
  
	VALUES_WHENDONE = [
	["A", "A"],
	["B", "B"],
	["C", "C"]
	].freeze
	
	def self.find_tagged_with(list, user)
	   find_by_sql([
            "SELECT items.* FROM items, tags, taggings " +
            "WHERE items.id = taggings.item_id " +            
            "AND taggings.tag_id = tags.id AND tags.name IN (?)" +
            "AND items.user_id = ?",
             list, user.id
          ])
	end
  
  def self.new_next(user)
		theitem = self.new(:user => user)
		res = Item.connection.select_one("SELECT MAX(number) AS maxnum FROM items " + 
		      "WHERE user_id = #{user.id}")
		maxnum = res['maxnum']
		if maxnum      
		  theitem.number = Integer(maxnum) + 1
		else
		  theitem.number = 1
		end
		theitem
	end
	
	def tag_string
	  self.tags.collect{|t| t.name}.join(" ") 
	end 
	
	def tag_with_manually(list, user)
    Tag.transaction do
      taggings.destroy_all   # the item instance's taggings 
      Tag.parse(list).each do |name|        
        Tag.where(:name => name, :user_id => user.id).first_or_create.add_item_manually(self, user)      
      end
    end   
  end
  
  protected 
  def sanitize_input 
    self.item_desc = Sanitize.clean(self.item_desc, :elements => HTML_ELEMENTS_ALLOWED, :attributes => HTML_ATTRIBUTES_ALLOWED, 
    :protocols => HTML_PROTOCOLS_ALLOWED)
  end 
      
end
