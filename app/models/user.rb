class User < ApplicationRecord
  before_destroy :check_all_events_finished

  has_many :created_events, class_name: "Event", foreign_key: "owner_id", dependent: :nullify
  has_many :tickets, dependent: :nullify
  has_many :participating_events, through: :tickets, source: :event

  def self.find_or_create_from_auth_hash!(auth_hash)
    user_params = self.user_params_from_auth_hash(auth_hash)
    User.find_or_create_by!(provider: user_params[:provider], uid: user_params[:uid]) do |user|
      user.update(user_params)
    end
  end

  private

  def check_all_events_finished
    now = Time.zone.now
    if created_events.where(":now < end_at", now: now).exists?
      errors[:base] << "公開中の未終了イベントが存在します。"
    end

    if participating_events.where(":now < end_at", now: now).exists?
      errors[:base] << "未終了の参加イベントが存在します。"
    end

    throw(:abort) unless errors.empty?
  end

  def self.user_params_from_auth_hash(auth_hash)
    {
      provider: auth_hash.provider,
      uid: auth_hash.uid,
      name: auth_hash.info.name,
      email: auth_hash.info.email,
      image_url: auth_hash.info.image,
    }
  end
end
