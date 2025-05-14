module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.valid_password?(password)
        token = SecureRandom.hex(20)
        
        {
          token: token,
          user: user,
          errors: []
        }
      else
        {
          token: nil,
          user: nil,
          errors: ["Credenciales inválidas"]
        }
      end
    end
  end
end