class Player < ApplicationRecord
  belongs_to :room
  has_many :records
end
