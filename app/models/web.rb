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

  def self.opened?(id)
    select(:open).where("id = ?", id).first.open
  end

  def self.attributes
    select(:outline, :open).map { |o| [o.outline, o.open] }
  end
end
