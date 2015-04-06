class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.find_by_omniauth(omniauth)
    self.find_by(provider: omniauth.provider, uid: omniauth.uid)
  end

  def self.create_by_omniauth(omniauth)
    self.create!(provider: omniauth.provider, uid: omniauth.uid)
  end
end
