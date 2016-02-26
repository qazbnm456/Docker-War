class Setting < ActiveRecord::Base
  before_save :falsify_all_others
  after_create :create_tenant

  private

  def change
    Indicator.first.update(:value => true) if self.active
  end

  def falsify_all_others
    change
    self.class.where('id != ? and active=1', self.id).update_all('active = 0')
    Indicator.first.update(:value => true) unless self.active
  end

  def create_tenant
    change
    falsify_all_others unless self.class.first.nil?
    Apartment::Tenant.create(self.tag)
  end
end