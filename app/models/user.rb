class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  has_many :act_types 
  has_many :items
  has_many :taggings
  has_many :tags 
  # attr_accessible :title, :body

  # New item date is the latest date of an item 
  def new_item_date
    newest_item = Item.where(:user_id => self.id).order("create_date DESC").first
    if newest_item
      newest_item.create_date
    else
      Time.new
    end
  end

end
