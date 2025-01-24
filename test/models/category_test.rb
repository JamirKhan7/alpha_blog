require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = Category.new(name: "Sport")
  end
  test "category should be valid" do
    @category = Category.new(name: "Sport")
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    @category_1 = Category.new(name: "Sport")
    assert_not @category_1.valid?
  end

  test "name should not be longer than 25 characters" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be smaller that 3 characters" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end