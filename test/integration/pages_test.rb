require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should get home' do
    # 1. reach home page ../pages/home
    # 2. response is successful
    get pages_home_url
    assert_response :success
  end
  
  test 'should get root' do
    # 1. reach home page ../
    # 2. response is successful
    get root_url
    assert_response :success
  end
end
