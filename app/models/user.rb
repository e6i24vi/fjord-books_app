# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_one_attached :avatar

  validate :image_content_type, if: :was_attached?

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/gif']
    errors.add(:avatar, 'の拡張子が間違っています') unless avatar.content_type.in?(extension)
  end

  def was_attached?
    avatar.attached?
  end
end
