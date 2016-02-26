class BasicController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'b1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Basic.flag(1).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('b1').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('b1').last_try_time
        if !@user.record.find_by_cate('b1').solved
          @user.score += 10
          @user.record.find_by_cate('b1').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('b1').update(finish_time: @user.last_submit_time)
            redirect_to wargame_basic_path
          else
            render 'basic/level1'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_basic_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'basic/level1'
      end
    end
  end

  def level2
    @ranked_players = Array.new
    Record.all.where(cate: 'b2').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Basic.flag(2).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('b2').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('b2').last_try_time
        if !@user.record.find_by_cate('b2').solved
          @user.score += 20
          @user.record.find_by_cate('b2').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('b2').update(finish_time: @user.last_submit_time)
            redirect_to wargame_basic_path
          else
            render 'basic/level2'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_basic_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'basic/level2'
      end
    end
  end

  def level3
    @ranked_players = Array.new
    Record.all.where(cate: 'b3').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Basic.url(3).first.url
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Basic.flag(3).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('b3').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('b3').last_try_time
        if !@user.record.find_by_cate('b3').solved
          @user.score += 30
          @user.record.find_by_cate('b3').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('b3').update(finish_time: @user.last_submit_time)
            redirect_to wargame_basic_path
          else
            render 'basic/level3'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_basic_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'basic/level3'
      end
    end
  end

  def level4
    @ranked_players = Array.new
    Record.all.where(cate: 'b4').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Basic.url(4).first.url
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Basic.flag(4).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('b4').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('b4').last_try_time
        if !@user.record.find_by_cate('b4').solved
          @user.score += 40
          @user.record.find_by_cate('b4').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('b4').update(finish_time: @user.last_submit_time)
            redirect_to wargame_basic_path
          else
            render 'basic/level4'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_basic_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'basic/level4'
      end
    end
  end

  def level5
    @ranked_players = Array.new
    Record.all.where(cate: 'b5').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Basic.url(5).first.url
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Basic.flag(5).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('b5').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('b5').last_try_time
        if !@user.record.find_by_cate('b5').solved
          @user.score += 50
          @user.record.find_by_cate('b5').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('b5').update(finish_time: @user.last_submit_time)
            redirect_to wargame_basic_path
          else
            render 'basic/level5'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_basic_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'basic/level5'
      end
    end
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:password)
  end
end