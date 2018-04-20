class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  belongs_to :user
  has_many :camps, through: :camp_instructors

  # validations
  validates_presence_of :first_name, :last_name
  #validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
  #validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }


  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  #scope :needs_bio, -> { where('bio IS NULL') }
  scope :needs_bio, -> { where(bio: nil) }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...

  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  # callbacks
  #before_save :reformat_phone
  
  
  before_destroy do
    check_if_taught_past_camps
    if errors.present?
      @delete_pass = false
      throw(:abort)
    else
      destroy_user_account
    end
  end
  
  after_rollback :convert_inactive_remove_upc_camps

  
  
  

  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

  private
  # def reformat_phone
  #   phone = self.phone.to_s  # change to string in case input as all numbers 
  #   phone.gsub!(/[^0-9]/,"") # strip all non-digits
  #   self.phone = phone       # reset self.phone to new string
  # end
  
  def deact_user_if_ins_inact
    if !self.active && !self.user.nil?
      self.user.active = false
      self.user.save
    end 
  end 
  
  def check_if_taught_past_camps
    unless self.camps.past.empty?
      errors.add(:base, 'Cannot delete instructor because they have taught past camps!')
    end 
  end 
  
  def destroy_user_account
    self.user.destroy
  end 
  
  def convert_inactive_remove_upc_camps
    if @delete_pass != true
      remove_upc_camps
      self.make_inactive
    end
    @delete_pass = nil 
  end 
  
  def remove_upc_camps
    self.camp_instructors.select { |camp_ins| camp_ins.camp.start_date >= Date.current }.each{ |camp_ins| camp_ins.destroy }
  end
  
  

end
