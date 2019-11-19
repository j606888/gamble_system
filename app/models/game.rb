class Game < ApplicationRecord
  belongs_to :room
  has_many :records, dependent: :destroy
  before_create :set_recorded_at

  # records = [
  #   {
  #     'id' => 3,
  #     'score' => 200
  #   },
  #   {
  #     'id' => 5,
  #     'score' => 460
  #   }
  # ]
  def self.create_with_records(records, email)
    return error_message(:all_zero) if all_zero?(records)
    sum = records.map { |r| r['score'].to_i }.compact.sum
    return error_message(sum) if sum != 0
    game = create(recorder: email)
    records.each do |r|
      next unless r['score'].present?
      game.records.create(r)
    end

    :success
  end

  def update_by_records(records_hash)
    sum = records_hash.map { |r| r['score'].to_i }.sum
    return Game.error_message(sum) if sum != 0

    records_hash.each do |r|
      record = records.find_by(player_id: r['player_id'])
      record.update!(score: r['score'])
    end
    :success
  end

  def self.create_from_line(records_hash)
    sum = records_hash.values.sum
    return sum if sum != 0

    force_from_line(records_hash)
  end

  def self.force_from_line(records_hash)
    game = create(recorder: 'line_bot')
    records_hash.each do |player_id, score|
      game.records.create(player_id: player_id, score: score)
    end
    :success
  end

  def date
    recorded_at.strftime("%F")
  end

  def detail
    hash = as_json(only:[:id, :recorder], methods: [:date])
    records.each { |r| hash[r.player_id] = r.score }
    hash
  end

  private

  def set_recorded_at
    self.recorded_at ||= Time.now
  end

  def self.error_message(num)
    if num.is_a?(Integer)
      num
    else
      "全數資料為0!"
    end
  end

  def self.all_zero?(records)
    records.each do |record|
      return false if record['score'] != ""
    end
    true
  end
end
