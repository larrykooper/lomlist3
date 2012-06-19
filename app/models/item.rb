class Item < ActiveRecord::Base
  attr_accessible :act_type, :create_date, :item_desc, :number, :out_indicator, :short_task_name, :swiss_cheese, :value_when_done, :where_to_do
  has_many :taggings, :dependent => :destroy   
  has_many :tags, :through => :taggings
  validates :number, :uniqueness => true
  
	VALUES_WHENDONE = [
	["A", "A"],
	["B", "B"],
	["C", "C"]
	].freeze
	
	def self.find_tagged_with(list)
	   find_by_sql([
            "SELECT items.* FROM items, tags, taggings " +
            "WHERE items.id = taggings.item_id " +            
            "AND taggings.tag_id = tags.id AND tags.name IN (?)",
             list
          ])
	end
  
  def self.new_next
		theitem = self.new 
		res = Item.connection.select_one("select max(number) as maxnum from items")	
		theitem.number = Integer(res['maxnum']) + 1
		theitem
	end
	
	def tag_string
	  self.tags.collect{|t| t.name}.join(" ") 
	end 
	
	def tag_with_manually(list)
    Tag.transaction do
      taggings.destroy_all
      Tag.parse(list).each do |name|        
        Tag.find_or_create_by_name(name).add_item_manually(self)        
      end
    end   
  end
      
end
