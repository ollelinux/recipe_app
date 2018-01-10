require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: 'chefme', email: 'chefme@mail.com', 
    password: 'password', password_confirmation: 'password')
    @recipe = Recipe.create(name: 'vegetable salad', 
    description: 'great vegetable salad', chef: @chef)
    @recipe.save
    @recipe2 = @chef.recipes.build(name: 'green sauce', 
    description: 'green salad and onion smash and mix together with olive oil')
    @recipe2.save
  end
  
  test 'should get chefs show' do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: @recipe.name
    assert_select 'a[href=?]', recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.name, response.body
  end
  
end
