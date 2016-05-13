class BasicController < ApplicationController
  prepend_before_action :test_ip
  before_action :authenticate_user!
  before_action :check_opened
  before_action :get_agent, :get_notice, :except => [:index]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, :alert => exception.message
  end

  def index
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'b1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Basic.url(1).first.url
    @chal = Basic.find_by_id(1)
    @hint = Hint.hint('b1').empty? ? "Empty here!" : Hint.hint('b1').first.hint
    @user = current_user
    @userpass = user_params[:flag]
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
    @url = Basic.url(2).first.url
    @chal = Basic.find_by_id(2)
    @hint = Hint.hint('b2').empty? ? "Empty here!" : Hint.hint('b2').first.hint
    @user = current_user
    @userpass = user_params[:flag]
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
    @chal = Basic.find_by_id(3)
    @hint = Hint.hint('b3').empty? ? "Empty here!" : Hint.hint('b3').first.hint
    @user = current_user
    @userpass = user_params[:flag]
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


  def content_save
    @chal = Basic.find_by(:id => params[:basic][:id])
    @chal.content = params[:basic][:content].gsub(/\'/, "&#39;").gsub(/(\r)+\n/, "")
    if !!@chal.save
      respond_to do |format|
        format.js { render partial: "shared/challenge_content_save" }
      end
    end
  end

  def content_edit
    @chal = Basic.find_by(:id => params[:basic][:id])
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
    if not current_user.admin?
      flash[:alert] = 'Not yet ready!'
      redirect_to (request.referer or home_path)
    end
  end

  def test_ip
    if cannot? :read, Basic
      raise CanCan::AccessDenied.new("Only ip from 140.117.0.0/16 allowed!", :read, Basic)
    end
  end
end