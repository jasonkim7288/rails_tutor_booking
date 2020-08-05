class Profile < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :about_me]

  belongs_to :user
  has_one_attached :picture

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
