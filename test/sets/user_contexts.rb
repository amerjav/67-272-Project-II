module Contexts
  module UserContexts
    # create your contexts here...
    def create_users
      @aj_user = FactoryBot.create(:user)
      @ali_user = FactoryBot.create(:user, username: "ali", phone: "422-319-4000")
      @rak_user = FactoryBot.create(:user, username: "rak", role: "instructor")
    end

    def delete_users
      @aj_user.delete
      @ali_user.delete
      @rak_user.delete
    end

    def create_more_users
      @mickey_user     = FactoryBot.create(:user, username: "mickey", role: "instructor")
      @saint_user  = FactoryBot.create(:user, username: "saint", role: "instructor")
      @ahmad_user   = FactoryBot.create(:user, username: "ahmad", role: "instructor")
      @nadia_user   = FactoryBot.create(:user, username: "nadia", role: "instructor")
    end

    def delete_more_users
      @mickey_user.delete    
      @saint_user.delete
      @ahmad_user.delete
      @nadia_user.delete
    end

    def create_family_users
      @jav_user = FactoryBot.create(:user, username: "jav", role: "parent")
      @trott_user   = FactoryBot.create(:user, username: "trott", role: "parent")
      @stutt_user     = FactoryBot.create(:user, username: "stutt", role: "parent")
      @iq_user     = FactoryBot.create(:user, username: "iq", role: "parent")

    end

    def delete_family_users
      @jav_user.delete
      @trott_user.delete
      @stutt_user.delete
      @iq_user.delete
    end
  end
end