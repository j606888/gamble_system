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

  def liff_link(type)
    "#{Setting.liff_link(type)}?source_id=#{source_id}"
  end

  private
  def setup_status
    self.status = 'normal_mode'
  end
end
