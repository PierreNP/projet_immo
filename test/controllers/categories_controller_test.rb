require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url, as: :json
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { balcony: @category.balcony, concierge: @category.concierge, elevator: @category.elevator, garden: @category.garden, house: @category.house, story: @category.story, studio: @category.studio, swimming_pool: @category.swimming_pool, t2: @category.t2, t3: @category.t3, terrace: @category.terrace } }, as: :json
    end

    assert_response 201
  end

  test "should show category" do
    get category_url(@category), as: :json
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { balcony: @category.balcony, concierge: @category.concierge, elevator: @category.elevator, garden: @category.garden, house: @category.house, story: @category.story, studio: @category.studio, swimming_pool: @category.swimming_pool, t2: @category.t2, t3: @category.t3, terrace: @category.terrace } }, as: :json
    assert_response 200
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category), as: :json
    end

    assert_response 204
  end
end
