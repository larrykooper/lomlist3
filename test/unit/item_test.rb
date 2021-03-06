require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @item = Item.find(1)
  end
 
  # I don't need to translate this one to RSpec because it just checks 
  # that the item fields after create are same as before create
  def test_create
    assert_kind_of Item,  @item
    assert_equal 1, @item.id
    assert_equal "1995-06-26 00:00:00", @item.create_date_before_type_cast
    assert_equal 208, @item.number
    assert_equal "LA" , @item.act_type
    assert_equal "Learn shiatsu massage", @item.item_desc        
  end
  
  # I don't need to translate this one to RSpec because it 
  # just checks that the item number is what I set it to after update 
  def test_update
	  assert_equal 208, @item.number 
	  @item.number = 2108
	  assert @item.save, @item.errors.full_messages.join("; ")
	  @item.reload
	  assert_equal 2108, @item.number
  end
  
 # def test_destroy
	#  @item.destroy
	#  assert_raise(ActiveRecord::RecordNotFound) { Item.find(@item.id) }
 # end
  
  # WOULD like to translate this to RSpec or cucumber
  def test_new_next
	  mything = Item.new_next
	  assert mything.number = 1686
  end   
  
end