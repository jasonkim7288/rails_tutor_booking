class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :delete_all
  has_many :tutor_sessions, dependent: :delete_all
  has_many :attendances, dependent: :delete_all

  enum role: [:normal, :admin]
end
