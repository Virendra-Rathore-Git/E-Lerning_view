class Course < ApplicationRecord
  belongs_to :teacher
  belongs_to :category
  has_one_attached :video
  validates :status, inclusion: { in: ["active", "inactive"] }
  validates :course_name, presence: true, uniqueness: { scope: :teacher_id }
  validates :course_desc, presence: true
  validates :video, presence: true
end
