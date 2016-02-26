class Forensic < ActiveRecord::Base
  def self.flag(id)
    select(:flag).where("id = ?", id)
  end

  def self.url(id)
    select(:url).where("id = ?", id)
  end
end