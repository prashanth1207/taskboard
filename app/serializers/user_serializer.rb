class UserSerializer < ActiveModel::Serializer
	attributes :id, :email, :username, :type, :created_at, :updated_at
end