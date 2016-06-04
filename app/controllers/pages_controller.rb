require 'diuitauth'
class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:chatroom, :wargame, :new_q, :qna_ans, :qna_edit, :qna_delete]
  before_action :load_data, only: :timeline
  before_action :disable_nav, only: :index

  def index
  end

  def home
    @all_news = News.all
    @qna = Qna.new
  end

  def chatroom
    if not current_user.admin?
      flash[:alert] = 'Not yet ready!'
      redirect_to (request.referer or home_path)
    end
    @token = getToken
  end

  def qna
    @qnas = Qna.all
  end

  def new_q
    @question = params[:qna][:question]
    loop do
      @question.gsub!(/(\\u|\\x)/, '')
      break if @question.scan(/(\\u|\\x)/).size == 0
    end
    @qna = Qna.new({:question => @question})
    if @qna.save
      respond_to do |format|
        format.js
      end
    end
  end

  def qna_ans
    @qna = Qna.find_by(:id => params[:qna][:id])
    @qna.answer = params[:qna][:answer]
    @qna.status = 1
    if !!@qna.save
      respond_to do |format|
        format.js
      end
    end
  end

  def qna_edit
    @qna = Qna.find_by(:id => params[:qna][:id])
    respond_to do |format|
      format.js
    end
  end

  def qna_delete
    @qna = Qna.find_by(:id => params[:qna][:id])
    @qna.destroy
    redirect_to qna_path
  end

  def rule
  end

  def about
  end

  def prize
  end

  def completed_records
    render json: ActiveRecord::Base.connection.execute('SELECT a.name, a.score FROM users AS a WHERE id != 1').chart_json
  end

  def timeline
    Record.all.order(last_try_time: :desc).where('last_try_time > ?', @@time).each do |r|
      if !r.last_try_time.nil?
        @@data["timeline"]["date"] << { "startDate" => r.last_try_time.strftime("%Y,%m,%d,%H,%M,%S"), "headline" => CGI::escape("#{I18n.t("page_ranking.description", :name => r.user.name, :cate => r.cate, :solved => r.solved)}") }
            #@@data["timeline"]["date"].inject({}) do |h, k|
              #(h[k["timeline"]["date"]["startDate"]] ||= {}).merge!(k){ |key, old, new| old || new }
              #h
            #end.values
      end
    end
    render json: @@data
  end

  def wargame
    @basic_outlines = Basic.attributes
    @web_outlines = Web.attributes
    @reverse_outlines = Reverse.attributes
    @crypto_outlines = Crypto.attributes
    @pwn_outlines = Pwn.attributes
  end

  def rank
    @s = Setting.find_by_active(true)
    @t = (@s.nil?) ? (Rails.env.production?) ? ENV['PD_DATABASE_NAME'] : Rails.env : @s.tag
    @ranked_players = Array.new
    if(params[:sort].blank?)
      User.all.where('id != 1').order(score: :desc, last_submit_time: :asc).includes(:record).each do |user|
        @ranked_players << user if user.confirmed?
      end
    else
      Record.all.where(cate: params[:sort], tag: @t).order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
        if r.user.id != 1
          @ranked_players << r.user if r.user.confirmed?
        end
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @ranked_players }
    end
  end

  def trend
    @s = Setting.find_by_active(true)
    @t = (@s.nil?) ? (Rails.env.production?) ? ENV['PD_DATABASE_NAME'] : Rails.env : @s.tag
    @scores = Array.new
    if(params[:id].blank?)
      User.all.where('id != 1').select { |u| u if u.confirmed? }.each_with_index do |user, index|
        @scores << { :name => user.name, :data => user.record.where("score != 0 and tag = '#{@t}'").map { |r| [r.finish_time.to_time.to_i*1000, r.score, r.cate] }.sort_by { |r| -r[1] } }
        @scores[index][:data] << [Time.zone.parse('2016-06-04 12:00').to_time.to_i*1000, 0]
        @scores[index][:data].sort_by! { |d| d[1]}
      end
    else
      User.where('id = ?', params[:id]).select { |u| u if u.confirmed? }.each_with_index do |user, index|
        @scores << { :name => user.name, :data => user.record.where("score != 0 and tag = '#{@t}'").map { |r| [r.finish_time.to_time.to_i*1000, r.score, r.cate] }.sort_by { |r| -r[1] } }
        @scores[index][:data] << [Time.zone.parse('2016-06-04 12:00').to_time.to_i*1000, 0]
        @scores[index][:data].sort_by! { |d| d[1]}
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @scores }
    end
  end

  private
    def load_data
      @@data = { "timeline" => { "headline" => "#{I18n.t("page_ranking.live_submission")}", "type" => "default", "text" => "MUCTF", "date" => [] } }
      @@time = DateTime.new(2014, 1, 1, 0, 0, 0)
    end

    def getToken
      private_key = "#{ENV['DIUIT_PRIVATE_KEY']}"
      exp = Time.now.utc.to_i + 4 * 3600

      client = {
          :app_id => "25c78f12f85021256c478e97bc496d72",
          :app_key => "053f399114d2be2dc906c32024d5ebc1",
          :key_id => "18bfbc1e381cb9db4c7a079a95ff5bcc",
          :private_key => "#{private_key}",
          :exp => "#{exp}",
          :platform => "ios_sandbox", # ['gcm', 'ios_sandbox', 'ios_production']
          :user_serial => current_user.email,
          :device_id => "f9c7ea67eb5da560f8f1d10cdfbafc75e225e9346a17a24f2677062360747bb8dc2a645686a58e4771d34de020f5d8b94dc30496611168250cb1515483277532"
      }

      return Diuitauth::Login.get_session_token client.to_json
    end
end