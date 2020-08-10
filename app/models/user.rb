class User < ApplicationRecord
  # role for the management. admin can do all the CRUD operations
  enum role: [:normal, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: :google_oauth2,
          authentication_keys: [:email]


  # relationship with other models
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :delete_all
  has_many :tutor_sessions, dependent: :delete_all
  has_many :attendances, dependent: :delete_all

  def self.create_from_provider_data(provider_data)
    puts("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    p "self.create_from_provider_data()"
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      case provider_data.provider
      when "google_oauth2"
        # user.full_name = provider_data.info.name
      else
      end
    end
  end
end
