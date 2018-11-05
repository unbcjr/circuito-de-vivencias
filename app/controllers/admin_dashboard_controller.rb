# frozen_string_literal: true

class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to(root_path) unless current_user.adminRole?
  end

  def home
  end

  def users
    @users = User.order(:name)
  end

end
