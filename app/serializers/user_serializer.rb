class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :role
  
  has_many :tasks, if: -> { instance_options[:include_tasks] }
end
