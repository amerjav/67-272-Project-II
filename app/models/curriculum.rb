class Curriculum < ApplicationRecord
  # relationships
  has_many :camps

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }


  #callbacks
  before destroy do
    cannot_destroy_object()
  end
  
  before_update :check_for_upc_reg_b4_inactive



  private
  def max_rating_greater_than_min_rating
    # only testing 'greater than' in this method, so...
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end
  
  
  def check_for_upc_reg_b4_inactive
    return true if (self.active == true)
    if any_upc_reg?
      errors.add(:base, "Curriculum cannot be made inactive as it has upcoming registrations.")
    end 
  end 
  
  def any_upc_reg?
    reg_count = self.camps.upcoming.map{ |c| c.registrations.count }
    registration_counts.inject(0) { |sum, rc| sum += rc}.zero? #total = 0 must be true
  end
    


end
