class CourseSerializer < ActiveModel::Serializer
  attributes :id,:course_name,:course_desc,:status,:category,:video
  belongs_to :category

  def category
    object.category.cat_name
  end
  
  def video
    object.video.url
  end

end
