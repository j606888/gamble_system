class Room < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :room_maps
  has_many :line_sources, through: :room_maps
  has_one :line_group
end
