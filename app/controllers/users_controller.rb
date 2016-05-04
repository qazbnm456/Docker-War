class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @id = params[:id]
    @user = User.includes(:sash => :badges_sashes).find_by(id: @id)
  end
end
