class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Set up accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :invitation_limit
  has_many :act_types 
  has_many :items
  has_many :taggings
  has_many :tags 
  after_invitation_accepted :set_up_new_user
  belongs_to :invited_by, :class_name => "User"
  # attr_accessible :title, :body
  
  INITIAL_ACT_TYPES = [
    ActType.new(:name => "MA"),  # "My agenda"
    ActType.new(:name => "SEC"), # "Secondary items on my agenda"
    ActType.new(:name => "MAINT"), # "Maintenance"
    ActType.new(:name => "FO"), # "For others"
    ActType.new(:name => "BUDG")  # "Budgeting and finances"
   ]
   
   SAMPLE_ITEM = Item.new(:create_date => Time.now, :number => 1, 
   :act_type => "MA",
   :item_desc => "Your sample item. Do an <b>important</b> thing. It might need a link to <a href=\"http://www.example.com\">www.example.com</a>.<br/><br/>Line breaks are nice! It might have <u>underline</u> or <i>italics</i>! Edit this item or delete it.")

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
    self.act_types=User::INITIAL_ACT_TYPES
    
    # Start them with a sample to-do item
    self.items << User::SAMPLE_ITEM
    
    # Ask for their first and last name
    
    # Show them the intro/faq/readme

  end

end
