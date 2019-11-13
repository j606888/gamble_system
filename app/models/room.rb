class Room < ApplicationRecord
  resourcify
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  has_one :line_group
  has_many :line_sources
  before_save :set_invite_code

  ALLOW_REPORT_TYPE = %w[winner loser counter]
  CHART_TYPE = %w[score]

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

  def players_analyse_array
    hash = {
      name: ['名稱'],
      total_score: ['分數'],
      game_count: ['總場次'],
      win: ['勝場'],
      lose: ['敗場'],
      win_rate: ['勝率'],
      average: ['平均每場']
    }
    players.avaliable.winner.each do |p|
      info = p.analyse
      hash[:name] << info[:name]
      hash[:total_score] << info[:total_score]
      hash[:game_count] << info[:game_count]
      hash[:win] << info[:win]
      hash[:lose] << info[:lose]
      hash[:win_rate] << info[:win_rate]
      hash[:average] << info[:average]
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

  def set_invite_code
    loop do
      self.invite_code = rand(100000..1000000)
      break if Room.find_by_invite_code(invite_code).nil?
    end
  end
end
