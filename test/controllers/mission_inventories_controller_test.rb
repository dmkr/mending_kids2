require 'test_helper'

class MissionInventoriesControllerTest < ActionController::TestCase
  setup do
    @mission_inventory = mission_inventories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mission_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mission_inventory" do
    assert_difference('MissionInventory.count') do
      post :create, mission_inventory: {  }
    end

    assert_redirected_to mission_inventory_path(assigns(:mission_inventory))
  end

  test "should show mission_inventory" do
    get :show, id: @mission_inventory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mission_inventory
    assert_response :success
  end

  test "should update mission_inventory" do
    patch :update, id: @mission_inventory, mission_inventory: {  }
    assert_redirected_to mission_inventory_path(assigns(:mission_inventory))
  end

  test "should destroy mission_inventory" do
    assert_difference('MissionInventory.count', -1) do
      delete :destroy, id: @mission_inventory
    end

    assert_redirected_to mission_inventories_path
  end
end
