class Liff::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_line_source

  layout "liff"

  private
  def set_line_source
    @line_source = LineSource.find_by(source_id: params[:source_id])
    return render json: { status: 404, error_mesage: "missing source id" } if @line_source.nil?
    @source_room = @line_source.room
    return render json: { status: 404, error_message: "room not found"} if @source_room.nil?
  end
end