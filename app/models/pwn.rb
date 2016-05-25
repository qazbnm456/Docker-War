class Pwn < ActiveRecord::Base
  def self.flag(id)
    select(:flag).where("id = ?", id)
  end

  def self.url(id)
    select(:url).where("id = ?", id)
  end

  def self.opened?(id)
    select(:open).where("id = ?", id).first.open
  end

  def self.attributes
    select(:outline, :open).map { |o| [o.outline, o.open] }
  end
end