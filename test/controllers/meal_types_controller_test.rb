require "test_helper"

class MealTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meal_type = meal_types(:one)
  end

  test "should get index" do
    get meal_types_url
    assert_response :success
  end

  test "should get new" do
    get new_meal_type_url
    assert_response :success
  end

  test "should create meal_type" do
    assert_difference("MealType.count") do
      post meal_types_url, params: { meal_type: { color: @meal_type.color, name: @meal_type.name, price: @meal_type.price } }
    end

    assert_redirected_to meal_type_url(MealType.last)
  end

  test "should show meal_type" do
    get meal_type_url(@meal_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_meal_type_url(@meal_type)
    assert_response :success
  end

  test "should update meal_type" do
    patch meal_type_url(@meal_type), params: { meal_type: { color: @meal_type.color, name: @meal_type.name, price: @meal_type.price } }
    assert_redirected_to meal_type_url(@meal_type)
  end

  test "should destroy meal_type" do
    assert_difference("MealType.count", -1) do
      delete meal_type_url(@meal_type)
    end

    assert_redirected_to meal_types_url
  end
end
