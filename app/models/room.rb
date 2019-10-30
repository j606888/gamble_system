class Room < ApplicationRecord
  resourcify
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  before_save :set_invite_code

  ALLOW_REPORT_TYPE = %w[winner loser counter]
  ALLOW_ROLES = %w[admin member]
  CHART_TYPE = %w[score]

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
        member: user.has_cached_role?(:member, self)
      }
    end
    hash
  end

  def is_private?
    !public
  end

  def hash_map
    hash = {}
    games.order(id: :desc).includes(:records).map do |game|
      game_hash = {
        date: game.display_time,
      }
      game.records.each do |record|
        game_hash[record.player_id] = record.score
      end
      hash[game.id] = game_hash
    end
    hash
  end

  private

  def header_maker(type='winner')
    select_players = players.avaliable.send(type)
    {
      name: ['遊戲時間'] + select_players.map(&:name) + ['記錄者'],
      money: ['分數'] + select_players.map(&:total_score) + [''],
      id: select_players.map(&:id)
    }
  end

  def body_maker
    games.order(id: :desc).includes(:records).map do |game|
      hash = {
        id: game.id,
        date: game.display_time,
        email: game.user&.email
      }
      game.records.each do |record|
        hash[record.player_id] = record.score
      end
      hash
    end
  end

  def set_invite_code
    self.invite_code = SecureRandom.hex(3)
  end
end
