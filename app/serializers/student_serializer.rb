class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile
end
