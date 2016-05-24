class PwnController < ApplicationController
  before_action :authenticate_user!
  before_action :check_opened, :only => [:level1, :level2, :level3, :level4, :level5]
  before_action :get_agent, :get_notice, :except => [:index]

  def index
    @pwn_outlines = Pwn.attributes
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'p1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Pwn.url(1).first.url
    @chal = Pwn.find_by_id(1)
    @hint = Hint.hint('p1').empty? ? "Empty here!" : Hint.hint('p1').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Pwn.flag(1).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('p1').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('p1').last_try_time
        if !@user.record.find_by_cate('p1').solved
          @user.score += 100
          @user.record.find_by_cate('p1').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('p1').update(finish_time: @user.last_submit_time)
            redirect_to wargame_pwn_path
          else
            render 'pwn/level1'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_pwn_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'pwn/level1'
      end
    end
  end

  def level2
    @ranked_players = Array.new
    Record.all.where(cate: 'p2').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Pwn.url(2).first.url
    @chal = Pwn.find_by_id(2)
    @hint = Hint.hint('p2').empty? ? "Empty here!" : Hint.hint('p2').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Pwn.flag(2).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('p2').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('p2').last_try_time
        if !@user.record.find_by_cate('p2').solved
          @user.score += 200
          @user.record.find_by_cate('p2').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('p2').update(finish_time: @user.last_submit_time)
            redirect_to wargame_pwn_path
          else
            render 'pwn/level2'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_pwn_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'pwn/level2'
      end
    end
  end

  def level3
    @ranked_players = Array.new
    Record.all.where(cate: 'p3').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Pwn.url(3).first.url
    @chal = Pwn.find_by_id(3)
    @hint = Hint.hint('p3').empty? ? "Empty here!" : Hint.hint('p3').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Pwn.flag(3).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('p3').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('p3').last_try_time
        if !@user.record.find_by_cate('p3').solved
          @user.score += 300
          @user.record.find_by_cate('p3').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('p3').update(finish_time: @user.last_submit_time)
            redirect_to wargame_pwn_path
          else
            render 'pwn/level3'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_pwn_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'pwn/level3'
      end
    end
  end

  def level4
    @ranked_players = Array.new
    Record.all.where(cate: 'p4').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Pwn.url(4).first.url
    @chal = Pwn.find_by_id(4)
    @hint = Hint.hint('p4').empty? ? "Empty here!" : Hint.hint('p4').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Pwn.flag(4).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('p4').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('p4').last_try_time
        if !@user.record.find_by_cate('p4').solved
          @user.score += 400
          @user.record.find_by_cate('p4').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('p4').update(finish_time: @user.last_submit_time)
            redirect_to wargame_pwn_path
          else
            render 'pwn/level4'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_pwn_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'pwn/level4'
      end
    end
  end

  def level5
    @ranked_players = Array.new
    Record.all.where(cate: 'p5').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Pwn.url(5).first.url
    @chal = Pwn.find_by_id(5)
    @hint = Hint.hint('p5').empty? ? "Empty here!" : Hint.hint('p5').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Pwn.flag(5).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('p5').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('p5').last_try_time
        if !@user.record.find_by_cate('p5').solved
          @user.score += 500
          @user.record.find_by_cate('p5').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('p5').update(finish_time: @user.last_submit_time)
            redirect_to wargame_pwn_path
          else
            render 'pwn/level5'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_pwn_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'pwn/level5'
      end
    end
  end

  def content_save
    @chal = Pwn.find_by(:id => params[:pwn][:id])
    @chal.content = params[:pwn][:content].gsub(/\'/, "&#39;").gsub(/(\r)+\n/, "")
    if !!@chal.save
      respond_to do |format|
        format.js { render partial: "shared/challenge_content_save" }
      end
    end
  end

  def content_edit
    @chal = Pwn.find_by(:id => params[:pwn][:id])
    respond_to do |format|
      format.js { render partial: "shared/challenge_content_edit" }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:flag)
  end

  def check_opened
    @tmp = controller_name.clone
    @tmp[0] = @tmp[0].capitalize
    @flag = @tmp.constantize.opened? action_name[-1]
    if (not current_user.admin?) && (@flag != true)
      flash[:alert] = 'Not yet ready!'
      redirect_to (request.referer or home_path)
    end
  end
end
