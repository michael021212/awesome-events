class User < ApplicationRecord
  def self.find_or_create_from_auth_hash!(auth_hash)
    user_params = self.user_params_from_auth_hash(auth_hash)
    User.find_or_create_by!(provider: user_params[:provider], uid: user_params[:uid]) do |user|
      user.update(user_params)
    end
  end

  private

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
