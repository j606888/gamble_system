class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy

  before_create :setup_default_time

  DISPLAY_TYPE = {
    'month' => "%Y-%m",
    'date' => "%F",
    'hour' => "%F %I:%M %P",
    'sec' => "%F %T"
  }

  def self.fast_create(records, email)
    return '全為0' if all_zero?(records)

    sum = records.map{|r| r['score'].to_i}.compact.sum
    return sum if sum != 0

    game = create(recorder: email)
    records.each do |r|
      next if r['score'].empty?
      game.records.create(r)
    end

    :success
  end

  def update_by_records(records_hash)
    sum = records_hash.map { |r| r['score'].to_i }.sum
    return sum if sum != 0

    records_hash.each do |r|
      record = records.find_by(player_id: r['player_id'])
      record.update!(score: r['score'])
    end
    :success
  end

  def display_time
    recorded_at.strftime("%F")
  end

  def detail
    hash = as_json(only:[:id, :recorder], methods: [:display_time])
    records.each { |r| hash[r.player_id] = r.score }
    hash
  end

  private

  def setup_default_time
    self.recorded_at ||= Time.now
  end

  def self.all_zero?(records)
    records.each do |record|
      return false if record['score'] != ""
    end
    true
  end
end
