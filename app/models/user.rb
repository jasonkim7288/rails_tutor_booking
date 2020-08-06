class User < ApplicationRecord
  # role for the management. admin can do all the CRUD operations
  enum role: [:normal, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relationship with other models
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :delete_all
  has_many :tutor_sessions, dependent: :delete_all
  has_many :attendances, dependent: :delete_all
end
