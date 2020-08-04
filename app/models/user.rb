class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :noti_setting, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tutor_sessions, dependent: :destroy
  has_many :attendances, dependent: :destroy

  enum role: [:normal, :admin]
end
