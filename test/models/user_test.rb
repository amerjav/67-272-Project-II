require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_secure_password

  # test validations
  should validate_presence_of(:username)

  #Role checks
  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)

  should_not allow_value("hi professor").for(:role)
  should_not allow_value("chef").for(:role)
  should_not allow_value(20).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)

  #Email checks
  should allow_value("amera@qatar.com").for(:email)
  should allow_value("amera@qatar.cmu.edu").for(:email)
  should allow_value("jennifer@mia.org").for(:email)
  should allow_value("aj.ahmad@cmu.net").for(:email)
  
  should_not allow_value("amer").for(:email)
  should_not allow_value("amer@qatar,com").for(:email)
  should_not allow_value("amer@qatar.ca").for(:email)
  should_not allow_value("hello fail@me.com").for(:email)
  should_not allow_value("dan@phelps.con").for(:email)
  should_not allow_value(nil).for(:email)
  
  #Phone checks
  should allow_value("4443332221").for(:phone)
  should allow_value("444-333-2222").for(:phone)
  should allow_value("444.222.1111").for(:phone)
  should allow_value("(444) 124-3333").for(:phone)
  
  should_not allow_value("7777777").for(:phone)
  should_not allow_value("4444444444x224").for(:phone)
  should_not allow_value("1800-HEY-OKAY").for(:phone)
  should_not allow_value("444/333/2222").for(:phone)
  should_not allow_value("444-4444-444").for(:phone)
  should_not allow_value(nil).for(:phone)
  
  
  # context
  context "Within context" do
    setup do
      create_users
    end
    
    teardown do
      delete_users
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "mheimann", @ali_user.username
      @ali_user.username = "ali"
      deny @ali_user.valid?, "#{@ali_user.username}"
    end

    should "allow user to authenticate with password" do
      assert @ali_user.authenticate("secret")
      deny @ali_user.authenticate("notsecret")
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "ali", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "ali", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "ali", password: "secret", password_confirmation: "saucy")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "ali", password: "no")
      deny bad_user.valid?
    end

    should "strip non-digits from the phone number" do
      assert_equal "4444444444", @ali_user.phone
    end


  end
end 