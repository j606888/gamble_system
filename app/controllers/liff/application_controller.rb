class Liff::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_join_rooms
end