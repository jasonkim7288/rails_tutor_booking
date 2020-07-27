class Profile < ApplicationRecord
  belongs_to :user

  def full_name
    return user.email.split("@")[0] if first_name == nil && last_name == nil
    return (first_name + " " + last_name).strip
  end
end
