class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student

  enum status: { pending: "pending", complete: "complete" }, _default: "pending"

  validates :course_id, uniqueness: { scope: :student_id }

end
