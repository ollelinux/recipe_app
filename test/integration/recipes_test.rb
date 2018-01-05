require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(name: 'chefme', email: 'chefme@mail.com')
    @recipe = Recipe.create(name: 'vegetable salad', description: 'great vegetable salad', chef: @chef)
    @recipe2 = @chef.recipes.build(name: 'chicken saute', description: 'great chicken dish')
    @recipe2.save
  end
  
  test 'should get recipes index' do
    get recipes_path
    assert_response :success
  end
  
  test 'should get recipes listing' do
    get recipes_path
    assert_template 'recipes/index'
    # check for params
    assert_match @recipe.name, response.body
    # check for a link
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_match @recipe2.name, response.body
    # check for a link
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test 'should get recipes show' do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
  end
  
end
