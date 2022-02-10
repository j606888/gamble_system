class Room < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :line_sources
  has_many :room_maps
  has_one :line_group

  ALLOW_REPORT_TYPE = %w[winner loser counter]

  def report(type='winner', need_recorder=false)
    raise 'not allow type' if ALLOW_REPORT_TYPE.exclude?(type)
    {
      header: header_maker(type, need_recorder),
      body: body_maker
    }
  end

  def hash_map
    hash = {}
    games.order(id: :desc).includes(:records).each do |game|
      hash[game.id] = game.detail
    end
    hash
  end

  private

  def header_maker(type='winner', need_recorder=false)
    select_players = players.avaliable.send(type)
    header = {
      name: ['遊戲時間'] + select_players.map(&:name),
      money: ['分數'] + select_players.map(&:total_score),
      id: select_players.map(&:id)
    }
    return header unless need_recorder
    header[:name] += ['記錄者']
    header[:money] += ['']
    header
  end

  def body_maker
    games.order(id: :desc).includes(:records).map(&:detail)
  end


end
