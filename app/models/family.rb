class Family < ApplicationRecord
    
    #relationships
    belongs_to :user
    has_many :students
    has_many :registrations, through: :students
    
    #validations
    validates_presence_of :family_name, :parent_first_name
    
    #scopes
    scope :alphabetical, -> { order('family_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) } 
    
    
    #callbacks
    before_destroy do
        cannot_destroy_object()
    end
    
    #before_update :inactive_fam_etc
    
    private ############################
    # def inactive_fam_etc
    #     if self.active == false
    #         destroy_upc_reg
    #         make_students_inactive
    #     end
    # end
    
    # def destroy_upc_reg
    #     self.registrations.select{|r| r.camp.start_date >= Date.current}.each{|r| r.destroy}
    # end 
    
    # def make_students_inactive
    #     self.students.each{ |s| s.make_students_inactive }
    # end 
    
    
end
