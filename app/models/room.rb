class Room < ApplicationRecord
  resourcify
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  before_save :set_invite_token

  ALLOW_REPORT_TYPE = %w[winner loser counter]
  ROLES = %w[admin helper member]

  def records
    arrays = []
    games.includes(:records).each do |g|
      arrays += g.records
    end
    arrays
  end

  def report(type='winner')
    raise 'not allow type' if ALLOW_REPORT_TYPE.exclude?(type)
    hash = {}
    hash[:header] = header_maker(type)
    hash[:body] = body_maker
    hash
  end

  def roles_map
    hash = {}
    User.with_role(:member, self).preload(:roles).each do |user|
      hash[user.id] = {
        email: user.email,
        name: user.name,
        admin: user.has_cached_role?(:admin, self),
        helper: user.has_cached_role?(:helper, self),
        member: user.has_cached_role?(:member, self)
      }
    end
    hash
  end

  def bash_update_roles(roles_params)
    # binding.pry
    roles_params.each do |roles|
      user = User.find(roles['user_id'])
      ROLES.each do |role|
        if roles[role].present?
          user.add_role(role, self)
        else
          user.remove_role(role, self)
        end
      end
    end
  end

  # false: remove_role, true: add_role
  def toggle_role(user, role)
    if user.has_role?(role, self)
      user.remove_role(role, self)
      return false
    else
      user.add_role(role, self)
      return true
    end
  end

  private
  def header_maker(type='winner')
    select_players = players.avaliable.send(type)
    {
      name: ['遊戲時間'] + select_players.map(&:name),
      money: ['分數'] + select_players.map(&:total_score),
      id: select_players.map(&:id)
    }
  end

  def body_maker
    hash = {}
    games.order(id: :desc).includes(:records).each do |game|
      game_hash = { id: game.id }
      game.records.each do |record|
        game_hash[record.player_id] = record.score
      end
      hash[game.display_time] = game_hash
    end
    hash
  end

  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
