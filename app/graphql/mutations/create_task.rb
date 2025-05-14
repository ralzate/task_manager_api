module Mutations
  class CreateTask < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :status, String, required: false
    argument :due_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :user_id, ID, required: true

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(title:, description: nil, status: 'pending', due_date: nil, user_id:)
      task = Task.new(
        title: title,
        description: description,
        status: status,
        due_date: due_date,
        user_id: user_id
      )

      if task.save
        {
          task: task,
          errors: []
        }
      else
        {
          task: nil,
          errors: task.errors.full_messages
        }
      end
    end
  end
end