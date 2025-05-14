# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin user] }

  scope :admins, -> { where(role: 'admin') }
  scope :regular_users, -> { where(role: 'user') }
end
