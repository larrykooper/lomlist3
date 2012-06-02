require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { act_type: @item.act_type, create_date: @item.create_date, item_desc: @item.item_desc, number: @item.number, out_indicator: @item.out_indicator, short_task_name: @item.short_task_name, swiss_cheese: @item.swiss_cheese, value_when_done: @item.value_when_done, where_to_do: @item.where_to_do }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    put :update, id: @item, item: { act_type: @item.act_type, create_date: @item.create_date, item_desc: @item.item_desc, number: @item.number, out_indicator: @item.out_indicator, short_task_name: @item.short_task_name, swiss_cheese: @item.swiss_cheese, value_when_done: @item.value_when_done, where_to_do: @item.where_to_do }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
