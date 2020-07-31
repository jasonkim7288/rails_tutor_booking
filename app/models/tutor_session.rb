class TutorSession < ApplicationRecord
  enum place: {
    offline: "Offline",
    online: "Online"
  }
  enum place_for_search: {
    any_place_for_search: "Any place",
    offline_for_search: "Offline",
    online_for_search: "Online"
  }
  enum category: {
    web_app: "Web app development",
    mobile_app: "Mobile app development",
    prog_lang:"Programming language"
  }
  enum category_for_search: {
    all_category_for_search: "All category",
    web_app_for_search: "Web app development",
    mobile_app_for_search: "Mobile app development",
    prog_lang_for_search:"Programming language"
  }

  NOT_FOUND_PICTURE = "https://images.unsplash.com/photo-1532619187608-e5375cab36aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"

  belongs_to :user
  after_initialize :init

  # set the default value when creating a new Model object
  def init
    self.place = :offline
    self.category = :web_app
    self.longitude = 0.0
    self.latitude = 0.0
  end
end
