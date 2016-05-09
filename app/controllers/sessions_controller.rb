require 'open3'
class SessionsController < Devise::SessionsController
  after_action :port_create, only: :create
  before_action :port_destroy, only: :destroy

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(params.permit(:email, :password))
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def sign_in(resource_or_scope, *args)
    options  = args.extract_options!
    scope    = Devise::Mapping.find_scope!(resource_or_scope)
    resource = args.last || resource_or_scope

    expire_data_after_sign_in!

    if options[:bypass]
      warden.session_serializer.store(resource, scope)
    elsif warden.user(scope) == resource && !options.delete(:force)
      # Do nothing. User already signed in and we are not forcing it.
      true
    else
      warden.set_user(resource, options.merge!(scope: scope))
    end

    @r = resource.record
    @s = Setting.find_by_active(true)
    @t = ((@s.nil?) ? (Rails.env.production?) ? ENV['PD_DATABASE_NAME'] : Rails.env : @s.tag)
    if @r.empty?
      records_assign(resource, @t)
    else
      if (!@r.map { |r| r.tag }.include?(@t))
        records_assign(resource, @t)
      end
    end
  end

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
        @port %= 65536
        @port += 49152
        while !User.update(current_user.id, :port => @port).valid? do
          @port += 1
          @port %= 65536
          @port += 49152
        end
      end
      flag_initialization
      cmd = Rails.root.join('script', 'playground.sh').to_s + " -n U_-#{current_user.email.gsub("@", "_0_")}- -p #{@port}"
      stdout, stderr, status = Open3.capture3(cmd)
      Rails.logger.info stdout
      Rails.logger.error stderr
    end
  end

  def port_destroy
    if current_user
      cmd = Rails.root.join('script', 'playground.sh').to_s + " -n U_-#{current_user.email.gsub("@", "_0_")}- -d"
      stdout, stderr, status = Open3.capture3(cmd)
      Rails.logger.info stdout
      Rails.logger.error stderr
      flag_destroy
    end
  end
end