class Hint < ActiveRecord::Base
  validates_uniqueness_of :cate

  def self.hint(cate_name)
    select(:hint).where("cate = ?", cate_name)
  end

  def cate_enum
    [
        ['b1'],['b2'],['b3'],['b4'],['b5'],
        ['w1'],['w2'],['w3'],['w4'],['w5'],
        ['r1'],['r2'],['r3'],['r4'],['r5'],
        ['c1'],['c2'],['c3'],['c4'],['c5'],
        ['p1'],['p2'],['p3'],['p4'],['p5']
    ]
  end
end