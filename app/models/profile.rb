class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  # if the user didn't input fist name and last name, just return the email address with only id part
  def full_name
    return user.email.split("@")[0] if (first_name == nil || first_name =="") && (last_name == nil || last_name == "")
    return (first_name + " " + last_name).strip
  end

  # get profile image depending on image_type
  def get_profile_image(user_name)
    if picture.attached?
      return picture
    else
      return "https://avatar.oxro.io/avatar.svg?name=#{user_name}&length=2"
    end
  end
end
