class Profile < ApplicationRecord
  # define enum
  # The default value is :type_initial which is 0. :type_initial uses Initaial Avatar URL, and :type_picture uses file
  # uploaded in Amazon S3 bucket
  enum img_type: [:type_initial, :type_picture]

  # relationship with other models
  belongs_to :user
  has_one_attached :picture

  # validation
  validates :name, length: {maximum: 100}
  validates :about_me, length: {maximum: 3000}
  validate :validate_phone_number

  # for keyword search
  include PgSearch::Model
  multisearchable against: [:name, :about_me]

  # if the user didn't input fist name and last name, just return the email address with only id part
  def get_name
    return self.user.email.split("@")[0] if self.name == nil || self.name ==""
    return self.name
  end

  # get profile image depending on img_type
  def get_profile_image(user_name=get_name)
    if self.type_picture?
      return self.picture
    else
      return "https://avatar.oxro.io/avatar.svg?name=#{user_name}&length=2"
    end
  end

  # custom validation to validate Australia phone number
  private
    def validate_phone_number
      if self.phone_number && self.phone_number != "" &&
        (self.phone_number.length > 20 || TelephoneNumber.invalid?(self.phone_number, :AU, [:mobile, :fixed_line]))
        self.errors[:phone_number] << 'has an invalid format of Australia'
      end
    end
end
