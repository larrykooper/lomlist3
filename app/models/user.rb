class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Set up accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  has_many :act_types 
  has_many :items
  has_many :taggings
  has_many :tags 
  # attr_accessible :title, :body
  
  INITIAL_ACT_TYPES = {
	  "MA" => "My agenda",
	  "SEC" => "Secondary items on my agenda" ,
    "MAINT" => "Maintenance",
    "FO" => "For others",
    "BUDG" => "Budgeting and finances"
   }

  # New item date is the latest date of an item 
  def new_item_date
    newest_item = Item.where(:user_id => self.id).order("create_date DESC").first
    if newest_item
      newest_item.create_date
    else
      Time.new
    end
  end
  
  def set_up_new_user 
    # Give them an initial set of act types 
    self.act_types.load(User::INITIAL_ACT_TYPES)
    
    # Start them with a sample to-do item
    self.items << (User::SAMPLE_ITEM)
    
    # Ask for their first and last name
    
    # Show them the intro/faq/readme

  end

end
