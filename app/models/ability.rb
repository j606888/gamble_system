# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.has_role?(:god)
      can :manage, :all
    else
      can :read, Room, id: Room.with_role(:member, user).pluck(:id)
    end
  end
end
