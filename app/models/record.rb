class Record < ApplicationRecord
  belongs_to :game
  belongs_to :player

  scope :win, -> { where("score > 0") }
  scope :lose, -> { where("score < 0") }
end
