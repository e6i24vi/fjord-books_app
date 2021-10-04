# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_one_attached :avatar

  validate :avatar_type

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def avatar_type
    return if avatar.blob.content_type.in?(%('image/jpeg image/png image/gif'))

    avatar = nil
    errors.add(:avatar, 'はjpegまたはpngまたはgif形式でアップロードしてください')
    avatar
  end
end
