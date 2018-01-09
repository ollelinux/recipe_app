require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    # this method runs before every other test
    def setup
        @chef = Chef.new(name: 'chefname', email: 'chefname@mail.com',
        password: 'password', password_confirmation: 'password')
    end
    
    # http://guides.rubyonrails.org/association_basics.html
    test 'chef should be valid' do
        assert @chef.valid?
    end
    
    test 'name should be present' do
        @chef.name = " "
        assert_not @chef.valid?
    end
    
    test 'email should be present' do
        @chef.email = " "
        assert_not @chef.valid?
    end
    
    test 'name should less than 250 characters' do
        @chef.name = "a" * 251
        assert_not @chef.valid?
    end
    
    test 'email shouldn\'t be more than 250 characters' do
        @chef.email = "a" * 251
        assert_not @chef.valid?
    end
    
    test 'email should accept correct format' do
        valid_emails = %w[user@example.com supername@gmail.com john+smith@co.uk.org]
        valid_emails.each do |valids|
            @chef.email = valids
            assert @chef.valid?, '#{valids.inspect} should be valid'
        end
    end
    
    test 'email should reject invalid emails' do
        invalid_emails = %w[user@example supername@gmail,com john+smith@co. uk.org joe@foo+bar.com]
        invalid_emails.each do |invalids|
            @chef.email = invalids
            assert_not @chef.valid?, '#{invalids.inspect} should be invalid'
        end
    end
    
    test 'email should be unique and case insensitive' do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not duplicate_chef.valid?
    end
    
    test 'email should be lower case before hitting db' do
        mixed_email = 'JohN@example.COM'
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email
    end
   
   test 'password should be present' do
       @chef.password = @chef.password_confirmation = ' '
       assert_not @chef.valid?
   end
   
   test 'password should be at least 5 characters' do
       @chef.password = @chef.password_confirmation = 'x' * 4
       assert_not @chef.valid?
   end
end