class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 8..10 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials email, password
    email = email.downcase.strip
    user = User.find_by_email(email)
    # If the user exists AND the password entered is correct.
      if user && user.authenticate(password)
      #if email and password succesfully authenticated
        return user
      end 
    #else
    return nil
  end

end
