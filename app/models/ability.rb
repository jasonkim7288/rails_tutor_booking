# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # all users can real all
    can :read, :all
    # if logged in
    if user.present?
      # any action for TutorSession and Profile is allowed only for the owner
      can :manage, TutorSession, user_id: user.id
      can :manage, Profile, user_id: user.id
      # admin can do everything
      if user.admin?
        can :manage, :all
      end
    end
  end
end
