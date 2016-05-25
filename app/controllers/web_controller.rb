class WebController < ApplicationController
  prepend_before_action :test_ip
  before_action :authenticate_user!
  before_action :check_opened, :only => [:level1, :level2, :level3]
  before_action :get_agent, :get_notice, :except => [:index]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, :alert => exception.message
  end

  def index
    @web_outlines = Web.attributes
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'w1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = distribution Web.url(1)
    @chal = Web.find_by_id(1)
    @hint = Hint.hint('w1').empty? ? "Empty here!" : Hint.hint('w1').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @flag = session[:web][:level1]
    @pass = Digest::SHA1.hexdigest @flag
    get_container(controller_name, action_name, Web.subdomain(1), @flag, Web.db(1))
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('w1').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('w1').last_try_time
        if !@user.record.find_by_cate('w1').solved
          @user.score += 100
          @user.record.find_by_cate('w1').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('w1').update(finish_time: @user.last_submit_time)
            redirect_to wargame_web_path
          else
            render 'web/level1'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_web_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'web/level1'
      end
    end
  end

  def level2
    @ranked_players = Array.new
    Record.all.where(cate: 'w2').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = distribution Web.url(2)
    @chal = Web.find_by_id(2)
    @hint = Hint.hint('w2').empty? ? "Empty here!" : Hint.hint('w2').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @flag = session[:web][:level2]
    @pass = Digest::SHA1.hexdigest @flag
    get_container(controller_name, action_name, Web.subdomain(2), @flag, Web.db(2))
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('w2').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('w2').last_try_time
        if !@user.record.find_by_cate('w2').solved
          @user.score += 200
          @user.record.find_by_cate('w2').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('w2').update(finish_time: @user.last_submit_time)
            redirect_to wargame_web_path
          else
            render 'web/level2'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_web_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'web/level2'
      end
    end
  end

  def level3
    @ranked_players = Array.new
    Record.all.where(cate: 'w3').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = distribution Web.url(3)
    @chal = Web.find_by_id(3)
    @hint = Hint.hint('w3').empty? ? "Empty here!" : Hint.hint('w3').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @flag = session[:web][:level3]
    @pass = Digest::SHA1.hexdigest @flag
    get_container(controller_name, action_name, Web.subdomain(3), @flag, Web.db(3))
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('w3').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('w3').last_try_time
        if !@user.record.find_by_cate('w3').solved
          @user.score += 300
          @user.record.find_by_cate('w3').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('w3').update(finish_time: @user.last_submit_time)
            redirect_to wargame_web_path
          else
            render 'web/level3'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_web_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'web/level3'
      end
    end
  end


  def content_save
    @chal = Web.find_by(:id => params[:web][:id])
    @chal.content = params[:web][:content].gsub(/\'/, "&#39;").gsub(/(\r)+\n/, "")
    if !!@chal.save
      respond_to do |format|
        format.js { render partial: "shared/challenge_content_save" }
      end
    end
  end

  def content_edit
    @chal = Web.find_by(:id => params[:web][:id])
    respond_to do |format|
      format.js { render partial: "shared/challenge_content_edit" }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:flag)
  end

  def distribution(url)
    url.gsub!(/\[:(.+)\]/) { if $1 === 'port' then current_user.port end}
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

  def test_ip
    if cannot? :read, Basic
      raise CanCan::AccessDenied.new("Only ip from 140.117.0.0/16 allowed!", :read, Basic)
    end
  end
end