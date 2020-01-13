class LineSource < ApplicationRecord
  belongs_to :room, optional: true
  has_many :room_maps
  has_many :rooms, through: :room_maps

  enum source_type: [:is_user, :is_group, :is_room]
  enum status: [:unbind_mode, :normal_mode, :player_mode, :record_mode]

  before_create :setup_status

  def other_rooms
    rooms - [room]
  end

  def switch_room(room_id)
    update(room_id: room_id)
  end

  def add_player_link
    "line://app/1653496919-gn1xDAZY?source_id=#{source_id}"
  end

  def player_index_link
    "line://app/1653496919-qlmKpk3r?source_id=#{source_id}"
  end

  def new_game_link
    "line://app/1653496919-Oaqv0m3k?source_id=#{source_id}"
  end

  def room_edit_link
    "line://app/1653496919-op36eGKE?source_id=#{source_id}&room_id=#{room.id}"
  end

  def room_show_link
    "line://app/1653496919-GmW6orDX?source_id=#{source_id}"
  end

  private
  def setup_status
    self.status = 'normal_mode'
  end
end
