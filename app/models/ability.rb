# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.has_role?(:god)
      can :manage, :all
    else
      # admin_id = Room.with_role(:admin, user).pluck(:id)
      # helper_id = Room.with_role(:helper, user).pluck(:id)
      # member_id = Room.with_role(:member, user).pluck(:id)
      # can :mangae, Room, id: admin_id
      # can :helper, Room, id: admin_id + helper_id
      # can :read, Room, id: admin_id + helper_id + member_id
      can :manage, Room, id: Room.with_role(:admin, user).pluck(:id)
      can :helper, Room, id: Room.with_role(:helper, user).pluck(:id)
      can :read, Room, id: Room.with_role(:member, user).pluck(:id)
    end
  end
end
