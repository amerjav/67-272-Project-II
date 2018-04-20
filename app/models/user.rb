class User < ApplicationRecord
    
    #relationships
    has_many :instructors
    has_many :families
    
    has_secure_password
    
    #validations
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :role, inclusion: { in: %w[admin instructor parent], message: "Please enter a valid role" }
    validates_presence_of :password, on: :create
    validates_presence_of :password_confirmation, on: :create
    validates_confirmation_of :password, message: "Does not match!"
    validates_uniqueness_of :email ######### not sure
    
    validates_length_of :password, minimum: 4, message: "Password must be at least 4 characters long", allow_blank: true 
    validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "Phone number must be 10 digits (area code required) and separated with dashes or dots"
    validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i, message: "Invalid email format"
    
    #callbacks
    before_save :reformat_phone
    
    
    private
    def reformat_phone
        self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
    end 
    
    
    
    
    
     
end
