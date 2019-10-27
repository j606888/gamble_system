class Room < ApplicationRecord
  resourcify
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  before_save :set_invite_token

  ALLOW_REPORT_TYPE = %w[winner loser counter]
  ALLOW_ROLES = %w[admin helper member]

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

  def bash_update_roles(roles_array)
    roles_array.each do |hash|
      user = User.find(hash['user_id'])
      ALLOW_ROLES.each do |role|
        hash[role].present? ? user.add_role(role, self) : user.remove_role(role, self)
      end
    end
  end

  def is_private?
    !public
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
    games.order(id: :desc).includes(:records).map do |game|
      hash = {
        id: game.id,
        date: game.display_time
      }
      game.records.each do |record|
        hash[record.player_id] = record.score
      end
      hash
    end
  end

  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
