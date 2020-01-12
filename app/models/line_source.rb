class LineSource < ApplicationRecord
  before_create :setup_status
  belongs_to :room, optional: true
  enum source_type: [:is_user, :is_group, :is_room]
  enum status: [:unbind_mode, :normal_mode, :player_mode, :record_mode]

  def add_player_link
    "line://app/1653496919-gn1xDAZY?source_id=#{source_id}"
  end

  def player_index_link
    "line://app/1653496919-qlmKpk3r?source_id=#{source_id}"
  end

  def new_game_link
    "line://app/1653496919-Oaqv0m3k?source_id=#{source_id}"
  end

  private
  def setup_status
    self.status = 'normal_mode'
  end
end
