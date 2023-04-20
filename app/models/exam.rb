class Exam < ApplicationRecord
  has_many :user
  belongs_to :exam_window
end
