module Contexts
    module FamilyContexts
        
        def create_families
            @javs = FactoryBot.create(:family, user: @jav_user)
            @trotts = FactoryBot.create(:family, user: @trott_user, family_name: "Trott", parent_first_name: "Michael")
            @stutts = FactoryBot.create(:family, user: @stutt_user, family_name: "Stuttgen", parent_first_name: "Peter")
        end
        
        def delete_families
            @javs.delete 
            @trots.delete 
            @stutts.delete
        end 
        
        def create_inactive_families
            @iq = FactoryBot.create(:family, user: @iq_user, family_name: "Iqram", parent_first_name: "Mohamed", active: false)
        end 
        
        def delete_inactive_families
            @iq.delete
        end 
        
    end 
    
end 