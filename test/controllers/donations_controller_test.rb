require 'test_helper'

class DonationsControllerTest < ActionController::TestCase
  setup do
    @donation = donations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation" do
    assert_difference('Donation.count') do
      post :create, donation: { brand: @donation.brand, donor_id: @donation.donor_id, expiration_date: @donation.expiration_date, fair_market_value: @donation.fair_market_value, inventory_id: @donation.inventory_id, item_description: @donation.item_description, lot_number: @donation.lot_number, mk_cost: @donation.mk_cost, quantity: @donation.quantity, total_in_kind_value: @donation.total_in_kind_value }
    end

    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should show donation" do
    get :show, id: @donation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation
    assert_response :success
  end

  test "should update donation" do
    patch :update, id: @donation, donation: { brand: @donation.brand, donor_id: @donation.donor_id, expiration_date: @donation.expiration_date, fair_market_value: @donation.fair_market_value, inventory_id: @donation.inventory_id, item_description: @donation.item_description, lot_number: @donation.lot_number, mk_cost: @donation.mk_cost, quantity: @donation.quantity, total_in_kind_value: @donation.total_in_kind_value }
    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should destroy donation" do
    assert_difference('Donation.count', -1) do
      delete :destroy, id: @donation
    end

    assert_redirected_to donations_path
  end
end
