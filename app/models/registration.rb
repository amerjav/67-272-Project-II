class Registration < ApplicationRecord
    
    require 'base64'
    
    belongs_to :camp
    belongs_to :student
    has_one :family, through: :student
    
    #validations
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    
    validate :active_student, on: :create
    validate :active_camp, on: :create
    validate :student_rating_appropo, on: :create
    validate :student_not_double_reg, on: :create
    validate :cc_number_valid
    validate :expiry_date_valid
    
    #scopes
    scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
    scope :for_camp, -> (camp_id) { where(camp_id: camp_id) }
    
    
    # #methods
    # def pay
    #     return false unless self.payment.nil?
    #     generate_payment_receipt
    #     self.save!
    #     self.payment
    # end

    def credit_card_type
        credit_card.type.nil? ? "N/A" : credit_card.type.name
    end
    
    # private
    # def student_rating_appropo
    #     return true if self.camp.nil? || self.student.nil?
    #     students_registered_at_that_time = Camp.where(start_date: self.camp.start_date, time_slot: self.camp.time_slot).map{|c| c.students }.flatten
    #     if students_registered_at_that_time.include?(self.student)
    #         errors.add(:base, "This student cannot be at two places at once, they are already registered at another camp at the same time.")
    #     end
    # end
    
    # def active_student
    #     is_active_in_system(:student)
    # end

    # def active_camp
    #     is_active_in_system(:camp)
    # end

    # def payment_receipt
    #     self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}; card: #{self.credit_card_type} ****#{self.credit_card_number[-4..-1]}")
    # end

#   def credit_card
#     CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
#   end
  
  
  #####
  
#   def cc_number_valid
#     return false if self.expiration_year.nil? || self.expiration_month.nil? ##false if no expiry info
#     if self.credit_card_number.nil? || credit_card.type.nil?
#       errors.add(:credit_card_number, "is not a valid credit card number.")
#       return false
#     end
#     true
#   end
  
#   def expiry_date_valid
#       return false if self.credit_card_number.nil?
#       cc = credit_card
#       if self.expiration_year.nil? || self.expiration_month.nil? || cc.expired?
#           errors.add(:expiration_year, "is expired")
#           return false
#       end 
#       true 
#   end 


    
    
end
