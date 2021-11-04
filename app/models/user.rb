# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_one_attached :avatar

  has_many :relationshipfs, foreign_key: :following_id, dependent: :destroy, inverse_of: :following
  has_many :followings, through: :relationshipfs, source: :follower

  has_many :reverse_of_relationshipfs, class_name: 'Relationshipf', foreign_key: :follower_id, dependent: :destroy, inverse_of: :follower
  has_many :followers, through: :reverse_of_relationshipfs, source: :following

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def followed_by?(user)
    reverse_of_relationshipfs.find_by(following_id: user.id).present?
  end
end
