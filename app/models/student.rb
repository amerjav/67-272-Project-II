class Student < ApplicationRecord
    
    #relationshipssss
    belongs_to :family
    has_many :registrations
    has_many :camps, through: :registrations
    
    
    
    
    #validationssss
    ratings_array = [0] + (100..3000).to_a
    validates :rating, numericality: { only_integer: true, allow_blank: true }, inclusion: { in: ratings_array, allow_blank: true }
    validates_presence_of :family_id, :first_name, :last_name
    validates :family_id, numericality: { only_integer: true, greater_than: 0 }
    validates :date_of_birth, :before => lambda { Date.today }, :before_message => "Date of birth cannot be in the future. Nothing is guaranteed in life!", allow_blank: true, on: :create
    validates :active_family, on: :create
    
    
    
    
    #shcopessh
    scope :alphabetical, -> { order('last_name, first_name') }
	scope :below_rating, ->(cap) { where('rating < ?', cap) }
	scope :at_or_above_rating, ->(min) { where('rating >= ?', min) }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    
    
    
    #callbax #################################################
    before_save :set_unrated_zero
    
    # before_destroy do
    #     check_if_ever_registered_for_past_camp
    #     if errors.present?
    #         @destroyable = false
    #         throw(:abort)
    #     else
    #         remove_upc_reg
    #     end
    # end

    #after_rollback :make_inactive_and_remove_reg

    
    
    
    #methods  ################################################
    def name
        "#{self.last_name}, #{self.first_name}"
    end 
    
    def proper_name
        "#{self.first_name} #{self.last_name}"
    end
    
    def age 
        return nil if date_of_birth.blank?
        (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
    end
    
    
    private ################################################
    # def active_family
    #     is_active_in_the_system(:family)
    # end
    
    def set_unrated_zero
        self.rating ||= 0
    end 
    
    #destroy if never registered, deactive if registered in past camp
    # def reg_past_camps_helper
    #     sr = self.registrations
    #     !sr.select{ |r| r.camp.start_date < Date.current }.empty?
    # end
    
    # def reg_past_camps
    #     return if self.registrations.empty?
    #     if reg_past_camps_helper?
    #         errors.add(:base, "This student has registered for a past camp and therefore cannot be destroyed. The student is however made inactive.")
    #     end
    # end
  
    # def remove_upc_reg
    #   return true if self.registrations.empty?
    #   upc_reg = self.registrations.select{ |r| r.camp.start_date >= Date.current }
    #   upc_reg.each { |upreg| upreg.destroy }
    # end 
  
    # #make student inactive if previously registered
    # def make_inactive_and_remove_reg
    #     if @destroyable == false
    #         remove_upc_reg
    #         self.make_inactive 
    #     end 
    #     @destroyable = nil 
    # end
    
    
    # def remove_upc_reg_inactive
    #     remove_upc_reg if !self.active
    # end
            
    
    
end
