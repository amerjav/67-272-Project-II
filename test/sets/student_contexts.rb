module Contexts
  module StudentContexts
      
    def create_students
        @amer = FactoryBot.create(:student, family: @javs, rating: 100)
        @hassan   = FactoryBot.create(:student, family: @trotts, first_name: "Has", last_name: "Trott", date_of_birth: 12.years.ago.to_date, rating: 1033)
        @danish = FactoryBot.create(:student, family: @stutts, first_name: "Danes", last_name: "Stuttgen", date_of_birth: 4.years.ago.to_date, rating: 400)
        @shaun   = FactoryBot.create(:student, family: @trotts, first_name: "Shaun", last_name: "Trott", date_of_birth: 23.years.ago.to_date, rating: 352)
        @nikki = FactoryBot.create(:student, family: @stutts, first_name: "Nicole", last_name: "Stuttgen", date_of_birth: 600.weeks.ago.to_date, rating: 999)
    end
    
    def delete_students
        @amer.delete
        @hassan.delete 
        @danish.delete
        @shaun.delete
        @nikki.delete
    end 
    
    def create_inactive_students
        @emad = FactoryBot.create(:student, family: @trotts, first_name: "Emad", last_name: "Iqram", date_of_birth: 71.years.ago.to_date, active: false, rating: nil)
    end 
    
    def delete_inactive_students
        @emad
    end 
  end
end 
    
    
