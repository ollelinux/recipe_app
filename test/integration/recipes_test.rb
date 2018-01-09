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
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: 'Edit this recipe'
    assert_select 'a[href=?]', recipe_path(@recipe), text: 'Delete this recipe'
  end
  
  test 'create new valid recipe' do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = 'chicken saute'
    description_of_recipe = 'add chicken, add vegetables, cook for 20 mins, serve delicious meal'
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe }}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test 'reject invalid recipe submission' do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " " }}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title' # - will be changed with the error message
    assert_select 'div.panel-body' # - will be changed with the error message
  end
  
end
