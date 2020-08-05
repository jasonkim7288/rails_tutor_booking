class PhoneNumberValidator < ActiveModel::Validator
  def validate(record)
    if record.phone_number != "" &&
      (record.phone_number.length > 20 || TelephoneNumber.invalid?(record.phone_number, :AU, [:mobile, :fixed_line]))
      record.errors[:phone_number] << 'has an invalid format of Australia'
    end
  end
end

class Profile < ApplicationRecord
  # relationship with other models
  belongs_to :user
  has_one_attached :picture

  # validation
  validates :name, length: {maximum: 100}
  validates :about_me, length: {maximum: 3000}

  # custom validation to validate Australia phone number
  include ActiveModel::Validations
  validates_with PhoneNumberValidator

  # for keyword search
  include PgSearch::Model
  multisearchable against: [:name, :about_me]

  # if the user didn't input fist name and last name, just return the email address with only id part
  def get_name
    return user.email.split("@")[0] if name == nil || name ==""
    return name
  end

  # get profile image depending on image_type
  def get_profile_image(user_name=get_name)
    if picture.attached?
      return picture
    else
      return "https://avatar.oxro.io/avatar.svg?name=#{user_name}&length=2"
    end
  end
end
