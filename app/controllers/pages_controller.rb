class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:wargame, :new_q, :qna_ans, :qna_edit]
  before_action :load_data, only: :timeline
  before_action :disable_nav, only: :index
  after_action :save_data, only: :timeline

  def index
  end

  def home
    @all_news = News.all
    @qna = Qna.new
  end

  def qna
    @qnas = Qna.all
  end

  def new_q
    @qna = Qna.new(params.require(:qna).permit(:question))
    if @qna.save
      respond_to do |format|
        format.js
      end
    end
  end

  def qna_ans
    @qna = Qna.find_by(id: params[:qna][:id])
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

  def help
  end

  def about
  end

  def completed_records
    render json: ActiveRecord::Base.connection.execute('SELECT a.name, a.score FROM users AS a WHERE id != 1').chart_json
  end

  def timeline
    Record.all.order(last_try_time: :desc).where('last_try_time > ?', @@time).each do |r|
      if !r.last_try_time.nil?
        @@data["timeline"]["date"] << { "startDate" => r.last_try_time.strftime("%Y,%m,%d,%H,%M,%S"), "headline" => "#{r.user.name} is playing #{r.cate}.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Solved: #{r.solved} " }
            #@@data["timeline"]["date"].inject({}) do |h, k|
              #(h[k["timeline"]["date"]["startDate"]] ||= {}).merge!(k){ |key, old, new| old || new }
              #h
            #end.values
      end
    end
    render json: @@data
  end

  def wargame
  end

  def rank
    @s = Setting.find_by_active(true)
    @t = (@s.nil?) ? (Rails.env.production?) ? ENV['DATABASE_NAME'] : Rails.env : @s.tag
    @ranked_players = Array.new
    if(params[:sort].blank?)
      User.all.where('id != 1').order(score: :desc, last_submit_time: :asc).includes(:record).each do |user|
        @ranked_players << user
      end
    else
      Record.all.where(cate: params[:sort], tag: @t).order(solved: :desc, finish_time: :asc).includes(:user => :record).each do |r|
        if r.user.id != 1
          @ranked_players << r.user
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
    User.all.where('id != 1').each_with_index do |user, index|
      @scores << { :name => user.name, :data => user.record.where("score != 0 and tag = '#{@t}'").map { |r| [r.finish_time.to_time.to_i*1000, r.score, r.cate] }.sort_by { |r| -r[1] } }
      @scores[index][:data] << [user.created_at.to_time.to_i*1000, 0]
    end
    respond_to do |format|
      format.html
      format.json { render json: @scores }
    end
  end

  private
    def load_data
      @@data = session[:data] || { "timeline" => { "headline" => "Live Submittion", "type" => "default", "text" => "Docker-War", "date" => [] } }
      @@time = session[:time] || DateTime.new(2014, 1, 1, 0, 0, 0)
    end

    def save_data
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      session[:time] = DateTime.current
      session[:data] = @@data
    end
end