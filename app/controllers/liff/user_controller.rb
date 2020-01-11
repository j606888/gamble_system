class Liff::UserController < ApplicationController
  def new
  end

  def create
    room = Room.find_by(source_id: params[:source_id])
    room.players.create(name: params[:name], nickname: params[:nickname])
    flash[:success] = 'create succuess'
    redirect_to liff_user_new_path
  end
end