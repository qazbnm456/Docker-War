class WebController < ApplicationController
  before_action :authenticate_user!
  before_action :get_agent, :get_notice, :except => [:index]

  def index
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

  def level4
    @ranked_players = Array.new
    Record.all.where(cate: 'w4').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = distribution Web.url(4)
    @chal = Web.find_by_id(4)
    @hint = Hint.hint('w4').empty? ? "Empty here!" : Hint.hint('w4').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @flag = session[:web][:level4]
    @pass = Digest::SHA1.hexdigest @flag
    get_container(controller_name, action_name, Web.subdomain(4), @flag, Web.db(4))
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('w4').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('w4').last_try_time
        if !@user.record.find_by_cate('w4').solved
          @user.score += 400
          @user.record.find_by_cate('w4').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('w4').update(finish_time: @user.last_submit_time)
            redirect_to wargame_web_path
          else
            render 'web/level4'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_web_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'web/level4'
      end
    end
  end

  def level5
    @ranked_players = Array.new
    Record.all.where(cate: 'w5').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = distribution Web.url(5)
    @chal = Web.find_by_id(5)
    @hint = Hint.hint('w5').empty? ? "Empty here!" : Hint.hint('w5').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @flag = session[:web][:level5]
    @pass = Digest::SHA1.hexdigest @flag
    get_container(controller_name, action_name, Web.subdomain(5), @flag, Web.db(5))
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('w5').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('w5').last_try_time
        if !@user.record.find_by_cate('w5').solved
          @user.score += 500
          @user.record.find_by_cate('w5').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('w5').update(finish_time: @user.last_submit_time)
            redirect_to wargame_web_path
          else
            render 'web/level5'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_web_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'web/level5'
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
end