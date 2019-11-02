class Room < ApplicationRecord
  resourcify
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  has_one :line_group
  before_save :set_default_setting

  ALLOW_REPORT_TYPE = %w[winner loser counter]
  CHART_TYPE = %w[score]

  def report(type='winner', need_recorder=false)
    raise 'not allow type' if ALLOW_REPORT_TYPE.exclude?(type)
    {
      header: header_maker(type, need_recorder),
      body: new_body_maker
    }
  end

  def hash_map
    hash = {}
    games.order(id: :desc).includes(:records).map do |game|
      game_hash = { date: game.display_time }
      game.records.each { |record| game_hash[record.player_id] = record.score }
      hash[game.id] = game_hash
    end
    hash
  end

  def players_analyse
    players.avaliable.winner.map { |p| p.analyse }
  end


  def new_body_maker
    games.order(id: :desc).includes(:records).map(&:detail)
  end

  # private

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
    games.order(id: :desc).includes(:records).map do |game|
      hash = {
        id: game.id,
        date: game.display_time,
        email: game.recorder
      }
      game.records.each do |record|
        hash[record.player_id] = record.score
      end
      hash
    end
  end

  def set_default_setting
    self.invite_code = rand(100000..1000000)
  end
end
