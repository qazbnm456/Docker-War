class Record < ActiveRecord::Base
  before_create :set_database_tag

  belongs_to :user, foreign_key: :user_id
  validates_uniqueness_of :user_id, scope: [:cate, :tag]

  def self.solved(uid)
    select(:solved).where("user_id = ? AND solved = ?", uid, 1).group(:cate).count
  end

  private

  def set_database_tag
    @s = Setting.find_by_active(true)
    @t = ((@s.nil?) ? (Rails.env.production?) ? ENV['PD_DATABASE_NAME'] : Rails.env : @s.tag)
    self.tag = @t if self.tag.nil?
  end
end