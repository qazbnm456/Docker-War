class CryptoController < ApplicationController
  prepend_before_action :test_ip
  before_action :authenticate_user!
  before_action :check_opened, :only => [:level1, :level2, :level3]
  before_action :get_agent, :get_notice, :except => [:index]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_url, :alert => exception.message
  end

  def index
    @crypto_outlines = Crypto.outlines
  end

  def level1
    @ranked_players = Array.new
    Record.all.where(cate: 'c1').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Crypto.url(1).first.url
    @chal = Crypto.find_by_id(1)
    @hint = Hint.hint('c1').empty? ? "Empty here!" : Hint.hint('c1').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Crypto.flag(1).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('c1').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('c1').last_try_time
        if !@user.record.find_by_cate('c1').solved
          @user.score += 100
          @user.record.find_by_cate('c1').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('c1').update(finish_time: @user.last_submit_time)
            redirect_to wargame_crypto_path
          else
            render 'crypto/level1'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_crypto_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'crypto/level1'
      end
    end
  end

  def level2
    @ranked_players = Array.new
    Record.all.where(cate: 'c2').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Crypto.url(2).first.url
    @chal = Crypto.find_by_id(2)
    @hint = Hint.hint('c2').empty? ? "Empty here!" : Hint.hint('c2').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Crypto.flag(2).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('c2').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('c2').last_try_time
        if !@user.record.find_by_cate('c2').solved
          @user.score += 200
          @user.record.find_by_cate('c2').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('c2').update(finish_time: @user.last_submit_time)
            redirect_to wargame_crypto_path
          else
            render 'crypto/level2'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_crypto_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'crypto/level2'
      end
    end
  end

  def level3
    @ranked_players = Array.new
    Record.all.where(cate: 'c3').order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
      if r.user.id != 1
        @ranked_players << r.user
      end
    end
    @url = Crypto.url(3).first.url
    @chal = Crypto.find_by_id(3)
    @hint = Hint.hint('c3').empty? ? "Empty here!" : Hint.hint('c3').first.hint
    @user = current_user
    @userpass = user_params[:flag]
    @pass = Digest::SHA1.hexdigest(Crypto.flag(3).first.flag)
    if !@userpass.nil?
      @userpass = Digest::SHA1.hexdigest @userpass
      @user.record.find_by_cate('c3').update(last_try_time: DateTime.current)
      if @userpass == @pass
        @user.last_submit_time = @user.record.find_by_cate('c3').last_try_time
        if !@user.record.find_by_cate('c3').solved
          @user.score += 300
          @user.record.find_by_cate('c3').update(solved: true, score: @user.score)
          if @user.save
            flash[:alert] = 'Congratulations!'
            @user.record.find_by_cate('c3').update(finish_time: @user.last_submit_time)
            redirect_to wargame_crypto_path
          else
            render 'crypto/level3'
          end
        else
          flash[:alert] = 'You\'ve passed the problem!'
          redirect_to wargame_crypto_path
        end
      else
        flash[:alert] = 'Failed! Maybe try again?'
        render 'crypto/level3'
      end
    end
  end


  def content_save
    @chal = Crypto.find_by(:id => params[:crypto][:id])
    @chal.content = params[:crypto][:content].gsub(/\'/, "&#39;").gsub(/(\r)+\n/, "")
    if !!@chal.save
      respond_to do |format|
        format.js { render partial: "shared/challenge_content_save" }
      end
    end
  end

  def content_edit
    @chal = Crypto.find_by(:id => params[:crypto][:id])
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
    @tmp = controller_name
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