class WithoutEnrollDataSerializer < ActiveModel::Serializer
  attributes :id,:course_name,:course_desc,:status,:category
  belongs_to :category

  def category
    object.category.cat_name
  end
end
