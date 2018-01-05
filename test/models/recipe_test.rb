require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    # this method runs before every other test
    def setup
        @recipe = Recipe.new(name: 'vegetable', description: 'greate vegetable recipe')
    end
    
    # http://guides.rubyonrails.org/association_basics.html
    test 'recipe should be valid' do
        assert @recipe.valid?
    end
    
    test 'name should be present' do
        @recipe.name = " "
        assert_not @recipe.valid?
    end
    
    test 'description should be present' do
        @recipe.description = " "
        assert_not @recipe.valid?
    end
    
    test 'description should have at least 5 characters' do
        @recipe.description = "a" * 3
        assert_not @recipe.valid?
    end
    
    test 'description shouldn\'t be more than 500 characters' do
        @recipe.description = "a" * 501
        assert_not @recipe.valid?
    end
    
end