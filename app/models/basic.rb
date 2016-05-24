class Basic < ActiveRecord::Base
  def self.flag(id)
    select(:flag).where("id = ?", id)
  end

  def self.url(id)
    select(:url).where("id = ?", id)
  end

  def self.opened?(id)
    select(:open).where("id = ?", id).first.open
  end

  def self.outlines
    select(:outline).map { |o| o.outline }
  end
end