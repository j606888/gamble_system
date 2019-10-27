class RolesController < ApplicationController
  before_action :set_current_room

  def bash_update
    @room.bash_update_roles(roles_params['roles'])
    flash[:success] = "Update Success"
    redirect_to control_room_path(@room)
  end

    def join
    result = @room.join(current_user, params[:password])
    if result == :success
      flash[:success] = "加入房間成功！"
      redirect_to @room
    else
      flash[:error] = "密碼錯誤！"
      redirect_to rooms_path
    end
  end

  def left
    if current_user.has_role?(:member, @room)
      current_user.remove_role(:member, @room)
      flash[:success] = "退出房間成功！"
    else
      flash[:warning] = "你本來就不在房間內了！"
    end
    redirect_to @room
  end

  def ask
    current_user.add_role(:ask, @room)
    flash[:success] = "已送出要求"
    redirect_to rooms_path
  end

  def reply_ask
    user = User.find(params[:user_id])
    answer = params[:answer]
    @room.reply_ask(user, answer)

    if answer == 'accept'
      flash[:success] = '已批准請求'
    else
      flash[:success] = '已移除請求'
    end

    redirect_to control_room_path(@room)
  end

  def remove_ask
    current_user.remove_role(:ask, @room)
    redirect_to like_rooms_path(@room)
  end

  private
  def roles_params
    params.permit(roles: [:user_id, :admin, :member, :helper])
  end
end