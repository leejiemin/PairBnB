require 'securerandom'

class User < ApplicationRecord
  include Clearance::User

  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy


  mount_uploader :avatar, AvatarUploader

  enum status: [:super_admin, :moderator, :customer]

  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      name: ["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication
    return user
  end
  
  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end


end

