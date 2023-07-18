class CourseSerializer < ActiveModel::Serializer
  attributes :id,:course_name,:course_desc,:status,:category,:video
  belongs_to :category

  def category
    object.category.cat_name
  end
  
  def user
    @current_user = @instance_options[:user]
  end

  def video
    if user.type=="Student"
      enrollment = @current_user&.enrollments.where(course_id: object.id)
      if enrollment.present?
          object.video.url
      else
        "You are not Enroll for this course"
      end
    else
         object.video.url
    end
  end
end
