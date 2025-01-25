require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(
                    username: "Jamir Khan",
                    email: "jamirk@mangospring.com",
                    password: "temp1234",
                    admin: true)
    sign_in_as(@admin_user)    
  end

  test "Get new category form and create a category" do
    get new_category_path
    assert_response :success

    assert_difference("Category.count", 1) do
      post categories_path, params: { category: { name: "Sport" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Sport", response.body
  end

  test "Get new category form and reject invalid category submission" do
    get new_category_path
    assert_response :success

    assert_no_difference("Category.count") do
      post categories_path, params: { category: { name: " " } }
    end

    assert_match "Errors", response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
