class Hint < ActiveRecord::Base
  validates_uniqueness_of :cate

  def self.hint(cate_name)
    select(:hint).where("cate = ?", cate_name)
  end

  def cate_enum
    [
        ['b1'],['b2'],['b3'],
        ['w1'],['w2'],['w3'],
        ['r1'],['r2'],['r3'],
        ['c1'],['c2'],['c3'],
        ['p1'],['p2'],['p3']
    ]
  end
end