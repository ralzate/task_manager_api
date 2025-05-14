class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date, :created_at, :updated_at
  
  belongs_to :user, if: -> { instance_options[:include_user] }
end
