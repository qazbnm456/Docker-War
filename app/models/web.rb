class Web < ActiveRecord::Base
  def self.subdomain(id)
    select(:subdomain).where("id = ?", id).first.subdomain
  end

  def self.db(id)
    select(:db).where("id = ?", id).first.db
  end

  def self.url(id)
    select(:url).where("id = ?", id).first.url
  end
end