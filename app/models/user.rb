class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
  :jwt_authenticatable, :registerable,
  jwt_revocation_strategy: JwtDenylist

  has_many :listings, foreign_key: 'landlord_id', dependent: :destroy, inverse_of: "landlord"
  has_many :places, through: :listings

  has_one_attached :avatar
end
