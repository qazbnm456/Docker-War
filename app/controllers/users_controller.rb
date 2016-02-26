class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.includes(:sash => :badges_sashes).find_by(id: params[:id])
  end
end
