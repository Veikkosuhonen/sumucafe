require "application_system_test_case"

class MenuItemsTest < ApplicationSystemTestCase
  setup do
    @menu_item = menu_items(:one)
  end

  test "visiting the index" do
    visit menu_items_url
    assert_selector "h1", text: "Menu items"
  end

  test "should create menu item" do
    visit menu_items_url
    click_on "New menu item"

    fill_in "Meal", with: @menu_item.meal_id
    fill_in "Menu date", with: @menu_item.menu_date
    fill_in "Restaurant", with: @menu_item.restaurant_id
    click_on "Create Menu item"

    assert_text "Menu item was successfully created"
    click_on "Back"
  end

  test "should update Menu item" do
    visit menu_item_url(@menu_item)
    click_on "Edit this menu item", match: :first

    fill_in "Meal", with: @menu_item.meal_id
    fill_in "Menu date", with: @menu_item.menu_date
    fill_in "Restaurant", with: @menu_item.restaurant_id
    click_on "Update Menu item"

    assert_text "Menu item was successfully updated"
    click_on "Back"
  end

  test "should destroy Menu item" do
    visit menu_item_url(@menu_item)
    click_on "Destroy this menu item", match: :first

    assert_text "Menu item was successfully destroyed"
  end
end
