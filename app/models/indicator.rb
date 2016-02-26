class Indicator < ActiveRecord::Base
  def can_go?
    self.class.first.value
  end

  def cant_go
    self.class.first.update(:value => false)
  end
end