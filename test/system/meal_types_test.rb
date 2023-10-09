require "application_system_test_case"

class MealTypesTest < ApplicationSystemTestCase
  setup do
    @meal_type = meal_types(:one)
  end

  test "visiting the index" do
    visit meal_types_url
    assert_selector "h1", text: "Meal types"
  end

  test "should create meal type" do
    visit meal_types_url
    click_on "New meal type"

    fill_in "Color", with: @meal_type.color
    fill_in "Name", with: @meal_type.name
    fill_in "Price", with: @meal_type.price
    click_on "Create Meal type"

    assert_text "Meal type was successfully created"
    click_on "Back"
  end

  test "should update Meal type" do
    visit meal_type_url(@meal_type)
    click_on "Edit this meal type", match: :first

    fill_in "Color", with: @meal_type.color
    fill_in "Name", with: @meal_type.name
    fill_in "Price", with: @meal_type.price
    click_on "Update Meal type"

    assert_text "Meal type was successfully updated"
    click_on "Back"
  end

  test "should destroy Meal type" do
    visit meal_type_url(@meal_type)
    click_on "Destroy this meal type", match: :first

    assert_text "Meal type was successfully destroyed"
  end
end
