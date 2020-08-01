class TutorSession < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :description, :place, :category, :address]

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
  has_many :comments, dependent: :destroy
  after_initialize :init

  def period
    start_date = self.start_datetime.to_time.strftime("%e %B")
    end_date = self.start_datetime.to_time.strftime("%e %B")
    return start_date == end_date ?start_date : "#{start_date} ~ #{end_date}"
  end

  def formatted_datetime

  end

  # return the proper title for filter
  def self.get_searched_title(param_search_text)
    if invalid_search_params?(param_search_text)
      return "Searched results"
    else
      return "Searched results for \"#{param_search_text}\""
    end
  end

  # search by keyword using pg_search gem
  def self.get_searched_result(param_search_text)
    return [] if invalid_search_params?(param_search_text)

    # PgSearch::Multisearch.rebuild(Profile)
    # PgSearch::Multisearch.rebuild(Comment)
    # PgSearch::Multisearch.rebuild(TutorSession)

    result_index = Set[]
    search_document = PgSearch.multisearch(param_search_text).limit(50)
    search_document.each do |document|
      case document.searchable_type
      when "TutorSession"
        result_index.add(document.searchable_id)
      when "Comment"
        temp_tutor_session = Comment.find(document.searchable_id).tutor_session
        result_index.add(temp_tutor_session.id)
      when "Profile"
        temp_tutor_sessions = Profile.find(document.searchable_id).user.tutor_sessions
        temp_tutor_sessions.each do |tutor_session|
          result_index.add(tutor_session.id)
        end
      else
      end
    end
    return self.where(id: result_index)
  end

  # return the proper title for filter
  def self.get_filtered_title(param_place, param_category)
    puts "------------------------------"
    p param_place, param_category
    if invalid_filter_params?(param_place, param_category)
      return "Filtered sessions"
    else
      is_any_place = (param_place == "any_place_for_search")
      return "#{(self.place_for_searches[param_place] + " ") if !is_any_place} #{self.category_for_searches[param_category]}#{" at any places" if is_any_place}"
    end
  end

  # search by filtering place type and category
  def self.get_filtered_result(param_place, param_category)
    if invalid_filter_params?(param_place, param_category)
      return []
    end

    param_place = param_place.to_sym
    param_category = param_category.to_sym

    if param_place == :any_place_for_search && param_category == :all_category_for_search
      return self.all.includes(:user)
    elsif param_place != :any_place_for_search && param_category == :all_category_for_search
      return self.where(place: matched_place_for_filter(param_place)).includes(:user)
    elsif param_place == :any_place_for_search && param_category != :all_category_for_search
      return self.where(category: matched_category_for_filter(param_category)).includes(:user)
    else
      return self.where(place: matched_place_for_filter(param_place), category: matched_category_for_filter(param_category)).includes(:user)
    end
  end

  def direction_url
    return "https://www.google.com/maps/dir/?api=1&destination=#{self.address.gsub(/ /, "+").gsub(/,/, "%2C")}"
  end

  private
    # set the default value when creating a new Model object
    def init
      self.place = :offline if self.place == nil
      self.category = :web_app if self.category == nil
      self.longitude = 0.0 if self.longitude == nil
      self.latitude = 0.0 if self.latitude == nil
    end

    def self.matched_place_for_filter (param_place)
      case param_place
      when :offline_for_search
        return :offline
      when :online_for_search
        return :online
      else
        return ""
      end
    end

    def self.matched_category_for_filter (param_category)
      case param_category
      when :web_app_for_search
        return :web_app
      when :mobile_app_for_search
        return :mobile_app
      when :prog_lang_for_search
        return :prog_lang
      else
        return ""
      end
    end

    def self.invalid_search_params?(param_search_text)
      if param_search_text == nil || param_search_text.length > 50
        return true
      else
        return false
      end
    end

    def self.invalid_filter_params?(param_place, param_category)
      if param_place == nil || param_category == nil || param_place.length > 30 || param_category.length > 30
        return true
      else
        return false
      end
    end
end
