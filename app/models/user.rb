class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
  :jwt_authenticatable, :registerable, :confirmable,
  jwt_revocation_strategy: JwtDenylist
  after_create :welcome_send

  
  has_many :listings, foreign_key: 'landlord_id', dependent: :destroy, inverse_of: "landlord"
  has_many :places, through: :listings

  has_one_attached :avatar

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end
  
  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end
  
  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end
  
  private
  
  def generate_token
    SecureRandom.hex(10)
  end
end
