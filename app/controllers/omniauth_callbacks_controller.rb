class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  after_action :port_create, only: :facebook

  def facebook
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?

      @r = @user.record
      @s = Setting.find_by_active(true)
      @t = ((@s.nil?) ? (Rails.env.production?) ? ENV['PD_DATABASE_NAME'] : Rails.env : @s.tag)
      if @r.empty?
        records_assign(@user, @t)
      else
        if (!@r.map { |r| r.tag }.include?(@t))
          records_assign(@user, @t)
        end
      end

      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  protected

  def records_assign(res, tag)
    res.record << Record.create({cate: 'b1', tag: tag})
    res.record << Record.create({cate: 'b2', tag: tag})
    res.record << Record.create({cate: 'b3', tag: tag})
    res.record << Record.create({cate: 'b4', tag: tag})
    res.record << Record.create({cate: 'b5', tag: tag})
    res.record << Record.create({cate: 'w1', tag: tag})
    res.record << Record.create({cate: 'w2', tag: tag})
    res.record << Record.create({cate: 'w3', tag: tag})
    res.record << Record.create({cate: 'w4', tag: tag})
    res.record << Record.create({cate: 'w5', tag: tag})
    res.record << Record.create({cate: 'r1', tag: tag})
    res.record << Record.create({cate: 'r2', tag: tag})
    res.record << Record.create({cate: 'r3', tag: tag})
    res.record << Record.create({cate: 'r4', tag: tag})
    res.record << Record.create({cate: 'r5', tag: tag})
    res.record << Record.create({cate: 'c1', tag: tag})
    res.record << Record.create({cate: 'c2', tag: tag})
    res.record << Record.create({cate: 'c3', tag: tag})
    res.record << Record.create({cate: 'c4', tag: tag})
    res.record << Record.create({cate: 'c5', tag: tag})
  end

  private

  def port_create
    if current_user
      @port = rand(49152...65536)
      if !User.update(current_user.id, :port => @port).valid?
        @port += 1
        @port += 49152 if @port == 65536 && @port %= 65536
        while !User.update(current_user.id, :port => @port).valid? do
          @port += 1
          @port += 49152 if @port == 65536 && @port %= 65536
        end
      end
      flag_initialization
      cmd = Rails.root.join('script', 'playground.sh').to_s + " -n u--#{current_user.email.gsub("@", "-0-").gsub(".", "-")}- -p #{@port}"
      stdout, stderr, status = Open3.capture3(cmd)
      Rails.logger.info stdout
      Rails.logger.error stderr
    end
  end
end