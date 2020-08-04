# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present?
      can :manage, TutorSession, user_id: user.id
      can :manage, Profile, user_id: user.id
      if user.admin?
        can :manage, :all
      end
    end
  end
end
