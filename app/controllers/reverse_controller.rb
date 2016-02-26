class ReverseController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'r1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Reverse.url(1).first.url
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Reverse.flag(1).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('r1').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('r1').last_try_time
        if !@user.record.find_by_cate('r1').solved
          @user.score += 100
          @user.record.find_by_cate('r1').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('r1').update(finish_time: @user.last_submit_time)
            redirect_to wargame_reverse_path
          else
            render 'reverse/level1'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_reverse_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'reverse/level1'
      end
    end
  end

  def level2
    @ranked_players = Array.new
    Record.all.where(cate: 'r2').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Reverse.url(2).first.url
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Reverse.flag(2).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('r2').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('r2').last_try_time
        if !@user.record.find_by_cate('r2').solved
          @user.score += 200
          @user.record.find_by_cate('r2').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('r2').update(finish_time: @user.last_submit_time)
            redirect_to wargame_reverse_path
          else
            render 'reverse/level2'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_reverse_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'reverse/level2'
      end
    end
  end

  def level3
    @ranked_players = Array.new
    Record.all.where(cate: 'r3').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Reverse.flag(3).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('r3').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('r3').last_try_time
        if !@user.record.find_by_cate('r3').solved
          @user.score += 300
          @user.record.find_by_cate('r3').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('r3').update(finish_time: @user.last_submit_time)
            redirect_to wargame_reverse_path
          else
            render 'reverse/level3'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_reverse_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'reverse/level3'
      end
    end
  end

  def level4
    @ranked_players = Array.new
    Record.all.where(cate: 'r4').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Reverse.flag(4).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('r4').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('r4').last_try_time
        if !@user.record.find_by_cate('r4').solved
          @user.score += 400
          @user.record.find_by_cate('r4').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('r4').update(finish_time: @user.last_submit_time)
            redirect_to wargame_reverse_path
          else
            render 'reverse/level4'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_reverse_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'reverse/level4'
      end
    end
  end

  def level5
    @ranked_players = Array.new
    Record.all.where(cate: 'r5').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @user = current_user
    @userpass = user_params[:password]
    @pass = Digest::SHA1.hexdigest(Reverse.flag(5).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('r5').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('r5').last_try_time
        if !@user.record.find_by_cate('r5').solved
          @user.score += 500
          @user.record.find_by_cate('r5').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('r5').update(finish_time: @user.last_submit_time)
            redirect_to wargame_reverse_path
          else
            render 'reverse/level5'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_reverse_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'reverse/level5'
      end
    end
  end
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:password)
  end
end