class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
  :jwt_authenticatable, :registerable,:confirmable,
  jwt_revocation_strategy: JwtDenylist
  after_create :welcome_send

  
  has_many :listings, foreign_key: 'landlord_id', dependent: :destroy, inverse_of: "landlord"
  has_many :places, through: :listings

  has_one_attached :avatar

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
