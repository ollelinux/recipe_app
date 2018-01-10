require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: 'chefme', email: 'chefme@mail.com', 
    password: 'password', password_confirmation: 'password')
  end
  
  test 'reject an invalid edit' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { name: '', email: 'bobby@mail.com' } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test 'accept valid edit' do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { name: 'bobby', email: 'bobby@mail.com' } }
    assert_redirected_to @chef #short form for a show page
    assert_not flash.empty?
    # need to reload to see the update of chef's info
    @chef.reload
    assert_match 'bobby', @chef.name
    assert_match 'bobby@mail.com', @chef.email
  end
  
end
