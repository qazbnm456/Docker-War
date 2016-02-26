class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    identity = find_by(provider: auth[:provider], uid: auth[:uid])
    if identity.nil?
      identity = create(uid: auth[:uid], provider: auth[:provider])
    end
    identity
  end
end