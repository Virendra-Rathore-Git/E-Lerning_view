class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates :course_id, uniqueness: { scope: :student_id }
end
