require 'test_helper'

class ActTypesControllerTest < ActionController::TestCase
  setup do
    @act_type = act_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:act_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create act_type" do
    assert_difference('ActType.count') do
      post :create, act_type: { name: @act_type.name }
    end

    assert_redirected_to act_type_path(assigns(:act_type))
  end

  test "should show act_type" do
    get :show, id: @act_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @act_type
    assert_response :success
  end

  test "should update act_type" do
    put :update, id: @act_type, act_type: { name: @act_type.name }
    assert_redirected_to act_type_path(assigns(:act_type))
  end

  test "should destroy act_type" do
    assert_difference('ActType.count', -1) do
      delete :destroy, id: @act_type
    end

    assert_redirected_to act_types_path
  end
end
