class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :type
end
