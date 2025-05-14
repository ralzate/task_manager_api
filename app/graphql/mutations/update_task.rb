module Mutations
  class UpdateTask < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false
    argument :due_date, GraphQL::Types::ISO8601DateTime, required: false

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      task = Task.find(id)
      
      if task.update(attributes)
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
    rescue ActiveRecord::RecordNotFound
      {
        task: nil,
        errors: ["La tarea con ID #{id} no fue encontrada"]
      }
    end
  end
end