class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id,:status,:student,:course
  belongs_to :course

  def student
    object.student.name
  end
end
