module Contexts
  module RegistrationContexts

    def create_registrations
      @amer_tactics    = FactoryBot.create(:registration, camp: @camp1, student: @amer)
      @hassan_endgames = FactoryBot.create(:registration, camp: @camp4, student: @hassan)
      @hassan_tactics  = FactoryBot.create(:registration, camp: @camp1, student: @hassan)
      @shaun_endgames  = FactoryBot.create(:registration, camp: @camp4, student: @shaun)
      @nikki_endgames = FactoryBot.create(:registration, camp: @camp4, student: @nikki)
    end

    def delete_registrations
      @amer_tactics.delete
      @hassan_endgames.delete
      @hassan_tactics.delete
      @shaun_endgames.delete
      @nikki_endgames.delete
    end
 end
end
  