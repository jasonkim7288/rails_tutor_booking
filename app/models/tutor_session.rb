class TutorSession < ApplicationRecord
  enum place: {any_place: "Any place", offline: "Offline", online: "Online"}
  enum category: {all_category: "All category", web_app: "Web app dev", mobile_app: "Mobile app dev", prog_lang:"Programming language"}
  belongs_to :user
end
