# frozen_string_literal: true

class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  layout 'adminDashboard/adminDashboard'

  def home; end

  def videos_index
    @videos = Video.all
  end

  def new_video
    @video = Video.new
  end

  def create_video
    @video = Video.new(video_params)
    if @video.save
      redirect_to adminDashboard_videos_path
    else
      redirect_to adminDashboard_post_video_path
    end
  end

  def delete_video
    @video = Video.find(params[:id])
    @video.delete
    redirect_to adminDashboard_videos_path
  end

  def users
    @users = User.order(:name)
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    user = User.find(params[:id])

    if user.update(user_params)
      flash[:notice] = "Usuário atualizado com sucesso!"
      redirect_to adminDashboard_users_path
    else
      flash[:notice] = "Não foi possível atualizar o usuário!"
      redirect_to adminDashboard_users_path
    end
  end

  def delete_user
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "Usuário deletado com sucesso!"
      redirect_to adminDashboard_users_path
    else
      flash[:alert] = "Não foi possível deletar o usuário!"
      redirect_to adminDashboard_users_path
    end
  end

  private

  def authenticate_admin
    redirect_to(root_path) unless Role.find(current_user.role_id).name == 'Admin'
  end

  def user_params
    params.require(:user).permit(
      :name,
      :surname,
      :cpf,
      :role_id
    )
  end

  def video_params
    params.require(:video).permit(
      :url,
      :title
    )
  end

end
