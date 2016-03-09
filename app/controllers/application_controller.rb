class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_timezone, :current_ability

  protected
  def disable_nav
    @disable_nav = true
  end

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def devise_parameter_sanitizer
    if resource_class == User
      #User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  def set_timezone
    if user_signed_in? && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def get_salt
    if user_signed_in?
      @keys = User.select(:port, :last_sign_in_at).where('id = ?', current_user.id)
      @tmp = @keys.first.port.to_s + @keys.first.last_sign_in_at.to_s
      @tmp.gsub!(/[: ]/, '_')
      @salt = [*'a'..'z', *'A'..'Z', *@tmp.split(//)].sample(40).join
    end
  end

  def flag_initialization
    session[:web] ||= {}
    session[:web][:level1] = get_salt
    session[:web][:level2] = get_salt
    session[:web][:level3] = get_salt
    session[:web][:level4] = get_salt
    session[:web][:level5] = get_salt
  end

  def flag_destroy(env=nil)
    if env.nil?
      session[:web][:level1] = nil
      session[:web][:level2] = nil
      session[:web][:level3] = nil
      session[:web][:level4] = nil
      session[:web][:level5] = nil
    else
      env['rack.session'][:web][:level1] = nil
      env['rack.session'][:web][:level2] = nil
      env['rack.session'][:web][:level3] = nil
      env['rack.session'][:web][:level4] = nil
      env['rack.session'][:web][:level5] = nil
    end
  end

  def get_container(controller_name, action_name, subdomain, flag, db)
    cmd = Rails.root.join('script', 'playground.sh').to_s + " -n #{current_user.email.gsub("@", "_0_")} -s #{subdomain} -f #{flag.inspect} -b #{(db.nil? || db.empty?) ? ''.inspect : db} -i #{controller_name+"_"+action_name}"
    stdout, stderr, status = Open3.capture3(cmd)
    Rails.logger.info stdout
    Rails.logger.error stderr
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
end
