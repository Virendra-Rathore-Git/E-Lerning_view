class Student < User
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses,through: :enrollments, class_name: 'Course', source: 'course' 
end
