class CustomValidator < ActiveModel::Validator
  def validate(record)
    # check if start_datetime has an valid format
    if ((record.start_datetime.strftime("%d/%m/%Y %l:%M %p") rescue ArgumentError) == ArgumentError)
      record.errors[:start_datatime] << 'has an invalid format'
    end
    # check if end_datetime has an valid format
    if ((record.end_datetime.strftime("%d/%m/%Y %l:%M %p") rescue ArgumentError) == ArgumentError)
      record.errors[:end_datatime] << 'has an invalid format'
    end
    # check if start_datetime is later than end_datetime
    if record.start_datetime && record.end_datetime && record.start_datetime.after?(record.end_datetime)
      record.errors[:end_datatime] << 'must be later than the start date/time'
    end

  end
end

class TutorSession < ApplicationRecord
  # define enum before validation to avoid undefined variable error
  # place enum is for storing place info to model or displaying place with a select tag on the tutor booking edit page
  enum place: {
    offline: "Offline",
    online: "Online"
  }

  # place_for_filter enum is for displaying place with a select tag on the tutor booking main page to filter
  enum place_for_filter: {
    any_place_for_filter: "Any place",
    offline_for_filter: "Offline",
    online_for_filter: "Online"
  }

  # category enum is for storing category info to model or displaying category with a select tag on the tutor booking edit page
  enum category: {
    web_app: "Web app development",
    mobile_app: "Mobile app development",
    prog_lang:"Programming language"
  }

  # category_for_filter enum is for displaying category with a select tag on the tutor booking main page to filter
  enum category_for_filter: {
    all_category_for_filter: "All category",
    web_app_for_filter: "Web app development",
    mobile_app_for_filter: "Mobile app development",
    prog_lang_for_filter:"Programming language"
  }

  # relationship with other models
  belongs_to :user
  has_many :comments, dependent: :delete_all
  has_many :attendances, dependent: :delete_all
  after_initialize :init

  # validation
  validates :header_img, :start_datetime, :end_datetime, presence: true
  validates :title, presence: true, length: {maximum: 300}
  validates :description, presence: true, length: {maximum: 3000}
  validates :place, presence: true, inclusion: {in: places.keys}
  validates :category, presence: true, inclusion: {in: categories.keys}
  validates :header_img, presence: true, length: {maximum: 300}
  validates :address, length: {maximum: 1000}
  validates :latitude, numericality: {greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :longitude, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :conf_url, format: {with: URI.regexp}, if: Proc.new {|record| record.conf_url.present?}, length: {maximum: 1000}
  validates :max_students_num, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 21}

  # custom validation
  include ActiveModel::Validations
  validates_with CustomValidator

  # for keyword search
  include PgSearch::Model
  multisearchable against: [:title, :description, :place, :category, :address]

  NOT_FOUND_PICTURE = "https://images.unsplash.com/photo-1532619187608-e5375cab36aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"

  def period
    start_date = self.start_datetime.to_time.strftime("%e %B")
    end_date = self.start_datetime.to_time.strftime("%e %B")
    return start_date == end_date ?start_date : "#{start_date} ~ #{end_date}"
  end

  # datetime format for the tutor_session new and edit form
  def datetime_format
    return "%d/%m/%Y %l:%M %p"
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
    if invalid_filter_params?(param_place, param_category)
      return "Filtered sessions"
    else
      is_any_place = (param_place == "any_place_for_filter")
      param_place = param_place.to_sym
      param_category = param_category.to_sym
      return "#{(self.place_for_filters[self.place_to_place_for_filter(param_place)] + " ") if !is_any_place} #{self.category_for_filters[self.category_to_category_for_filter(param_category)]}#{" at any places" if is_any_place}"
    end
  end

  # search by filtering place type and category
  def self.get_filtered_result(param_place, param_category)
    if invalid_filter_params?(param_place, param_category)
      return []
    end

    param_place = self.place_to_place_for_filter(param_place.to_sym)
    param_category = self.category_to_category_for_filter(param_category.to_sym)

    if param_place == :any_place_for_filter && param_category == :all_category_for_filter
      return self.all.includes(:user)
    elsif param_place != :any_place_for_filter && param_category == :all_category_for_filter
      return self.where(place: place_for_filter_to_place(param_place)).includes(:user)
    elsif param_place == :any_place_for_filter && param_category != :all_category_for_filter
      return self.where(category: category_for_filter_to_category(param_category)).includes(:user)
    else
      return self.where(place: place_for_filter_to_place(param_place), category: category_for_filter_to_category(param_category)).includes(:user)
    end
  end

  def direction_url
    return "https://www.google.com/maps/dir/?api=1&destination=#{self.address.gsub(/ /, "+").gsub(/,/, "%2C")}"
  end

  private
    # set the default value when creating a new Model object
    def init
      self.place ||= :offline
      self.category ||= :web_app
      self.longitude ||= 0.0
      self.latitude ||= 0.0
    end

    # when click the place on the show page, the value like :offline or :online will also be used for filtering
    def self.place_for_filter_to_place (param_place)
      case param_place
      when :offline_for_filter
        return :offline
      when :offline
        return :offline
      when :online_for_filter
        return :online
      when :online
        return :online
      else
        return ""
      end
    end

    # when click the place on the show page, the value like :offline or :online will also be used for filtering
    def self.place_to_place_for_filter (param_place)
      case param_place
      when :offline
        return :offline_for_filter
      when :online
        return :online_for_filter
      when :offline_for_filter
        return param_place
      when :online_for_filter
        return param_place
      when :any_place_for_filter
        return param_place
      else
        return ""
      end
    end

    # when click the category on the show page, the value like :web_app, :mobile_app, or :prog_lang will also be used for filtering
    def self.category_for_filter_to_category (param_category)
      case param_category
      when :web_app_for_filter
        return :web_app
      when :web_app
        return :web_app
      when :mobile_app_for_filter
        return :mobile_app
      when :mobile_app
        return :mobile_app
      when :prog_lang_for_filter
        return :prog_lang
      when :prog_lang
        return :prog_lang
      else
        return ""
      end
    end

    # when click the category on the show page, the value like :web_app, :mobile_app, or :prog_lang will also be used for filtering
    def self.category_to_category_for_filter (param_category)
      case param_category
      when :web_app
        return :web_app_for_filter
      when :mobile_app
        return :mobile_app_for_filter
      when :prog_lang
        return :prog_lang_for_filter
      when :web_app_for_filter
        return param_category
      when :mobile_app_for_filter
        return param_category
      when :prog_lang_for_filter
        return param_category
      when :all_category_for_filter
        return param_category
      else
        return ""
      end
    end

    # if the parameter is nil or its length is too long, return ture
    def self.invalid_search_params?(param_search_text)
      if param_search_text == nil || param_search_text.length > 50
        return true
      else
        return false
      end
    end

    # if the parameters are nill or their lengths are too long, return ture
    def self.invalid_filter_params?(param_place, param_category)
      if param_place == nil || param_category == nil || param_place.length > 30 || param_category.length > 30
        return true
      else
        return false
      end
    end
end
