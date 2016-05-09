class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_timezone, :set_locale, :current_ability

  SecureHeaders::Configuration.default do |config|
    config.cookies = {
        secure: true, # mark all cookies as "Secure"
        httponly: true, # mark all cookies as "HttpOnly"
        samesite: {
            strict: true # mark all cookies as SameSite=Strict
        }
    }
    config.hsts = OPT_OUT
    config.x_frame_options = "DENY"
    config.x_content_type_options = "nosniff"
    config.x_xss_protection = "1; mode=block"
    config.x_download_options = "noopen"
    config.x_permitted_cross_domain_policies = "none"
    config.csp = {
        # "meta" values. these will shaped the header, but the values are not included in the header.
        report_only:  Rails.env.development?,     # default: false
        preserve_schemes: Rails.env.development?, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.

        # directive values: these values will directly translate into source directives
        default_src: %w(https: 'self'),
        frame_src: %w('self'),
        connect_src: %w('self' wss://wargame.cse.nsysu.edu.tw:444),
        font_src: %w('self' fonts.gstatic.com data:),
        img_src: %w('self' data:),
        media_src: %w('self'),
        object_src: %w('self'),
        script_src: %w(https: 'self' www.google.com 'unsafe-inline'),
        style_src: %w(https: 'self' 'unsafe-inline'),
        base_uri: %w('self'),
        child_src: %w('self'),
        form_action: %w('self'),
        frame_ancestors: %w('none'),
        plugin_types: %w(application/x-shockwave-flash),
        block_all_mixed_content: true, # see [http://www.w3.org/TR/mixed-content/](http://www.w3.org/TR/mixed-content/)
        upgrade_insecure_requests: true, # see https://www.w3.org/TR/upgrade-insecure-requests/
        report_uri: %w(https://331f16c75888d350134a58be3b017b7a.report-uri.io/r/default/csp/enforce)
    }
    config.hpkp = {
        report_only: false,
        max_age: 270.days.to_i,
        include_subdomains: true,
        report_uri: "https://331f16c75888d350134a58be3b017b7a.report-uri.io/r/default/hpkp/enforce",
        pins: [
            {sha256: "CYGFpDKIH2YoOm4jPvWZt6uWt/33dO4ReDBUQdhbTJs="},
            {sha256: "+jZrZTw2Qn84hZSEHdg1EbpcSpj7HDgV0iw+gB+U3As="}
        ]
    }
  end

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
    else
      Time.zone = "Taipei"
    end
  end

  def set_locale
    @req_lang = extract_locale_from_accept_language_header

    session[:locale] = case
             when DockerWar::Application::VALID_LANG.include?( params[:locale] ) then params[:locale]
             when session[:locale] then session[:locale]
             when DockerWar::Application::VALID_LANG.include?( @req_lang ) then @req_lang
             end

    I18n.locale = session[:locale] || I18n.default_locale
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
    cmd = Rails.root.join('script', 'playground.sh').to_s + " -n U_-#{current_user.email.gsub("@", "_0_")}- -s #{subdomain} -f #{flag.inspect} -b #{(db.nil? || db.empty?) ? ''.inspect : db} -i #{controller_name+"_"+action_name}"
    stdout, stderr, status = Open3.capture3(cmd)
    Rails.logger.info stdout
    Rails.logger.error stderr
  end

  def get_agent
    @agent = DockerShellHelper::Rancher.new
    @agent.rancher_scheme = 'https'
    @agent.rancher_host = 'wargame.cse.nsysu.edu.tw'
    @agent.rancher_port = '444'
    @agent.access_key = ENV['RANCHER_ACCESS_KEY']
    @agent.secret_key = ENV['RANCHER_SECRET_KEY']
    @agent.container_name = "VPS_#{current_user.email.gsub("@", "_0_")}"
    @agent
  end

  def get_notice
    @notice = vps_notice
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  private
  def extract_locale_from_accept_language_header
    @lang = request.env['HTTP_ACCEPT_LANGUAGE']
    @lang = @lang.nil? ? nil : @lang[/[^,;]+/]
  end

  def vps_notice
    "# set up the path\\r\\n"\
    "/path/to/ctf-tools/bin/manage-tools setup\\r\\n"\
    "source ~/.bashrc\\r\\n"\
    "\\r\\n"\
    "# list the available tools\\r\\n"\
    "manage-tools list\\r\\n"\
    "\\r\\n"\
    "# install gdb, allowing it to try to sudo install dependencies\\r\\n"\
    "manage-tools -s install gdb\\r\\n"\
    "\\r\\n"\
    "# install pwntools, but don't let it sudo install dependencies\\r\\n"\
    "manage-tools install pwntools\\r\\n"\
    "\\r\\n"\
    "# uninstall gdb\\r\\n"\
    "manage-tools uninstall gdb\\r\\n"\
    "\\r\\n"\
    "# uninstall all tools\\r\\n"\
    "manage-tools uninstall all\\r\\n"\
    "\\r\\n"\
    "# search for a tool\\r\\n"\
    "manage-tools search preload\\r\\n"
  end
end
