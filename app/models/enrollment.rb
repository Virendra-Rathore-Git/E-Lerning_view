class Enrollment < ApplicationRecord
  belongs_to :student 
  belongs_to :course
  enum status: { pending: "pending", complete: "complete" }, _default: "pending"
  validates :course_id, uniqueness: { scope: :student_id }

end
