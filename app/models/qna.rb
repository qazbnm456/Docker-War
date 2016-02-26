class Qna < ActiveRecord::Base
  validates :question, presence: true
end