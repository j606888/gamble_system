class Liff::UserController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_join_rooms

  def new
    render layout: false
  end

  def create
    line_source = LineSource.find_by(source_id: params[:source_id])
    room = line_source.room
    room.players.create(name: params[:name], nickname: params[:nickname])
    flash[:success] = 'create succuess'
    redirect_to liff_user_new_path
  end
end