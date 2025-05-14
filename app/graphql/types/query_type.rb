module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false,
      description: "Devuelve una lista de usuarios"
    
    def users
      User.all
    end

    field :user, Types::UserType, null: true do
      description "Encuentra un usuario por ID"
      argument :id, ID, required: true
    end
    
    def user(id:)
      User.find(id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    field :tasks, [Types::TaskType], null: false,
      description: "Devuelve una lista de tareas"
    
    def tasks
      if context[:current_user].nil?
        raise GraphQL::ExecutionError, "Debes iniciar sesión para ver las tareas"
      end
      
      if context[:current_user].role == 'admin'
        Task.all
      else
        context[:current_user].tasks
      end
    end
  end
end