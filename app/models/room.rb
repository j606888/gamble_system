class Room < ApplicationRecord
  before_save :set_invite_token

  private
  def set_invite_token
    self.invite_token = SecureRandom.hex(3)
  end
end
