require 'open3'
class RegistrationsController < Devise::RegistrationsController
  after_action :port_create, only: :create
  before_action :port_destroy, only: :destroy
  
  def new
    super
  end

  def create
    params[:user].merge! params[:user][:sex]
    params[:user].merge! params[:user][:major]
    params[:user].except!(:sex)
    params[:user].except!(:major)
    params[:user][:port] = 49152 + User.maximum(:id).to_i.next
    #above is optimization for sex, major and port

    #build_resource(sign_up_params)
    build_resource(params.require(:user).permit(:name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation, :port))

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: show_user_path(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    params[:user].merge! params[:user][:sex]
    params[:user].merge! params[:user][:major]
    params[:user].except!(:sex)
    params[:user].except!(:major)
    #above is optimization for
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, params.require(:user).permit(:avatar, :name, :sex_id, :major_id, :email, :time_zone, :password, :password_confirmation, :current_password))
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      #respond_with resource, location: after_update_path_for(resource)
      respond_with resource, location: show_user_path(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

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
      cmd = Rails.root.join('script', 'playground.sh').to_s + " -n u--#{current_user.email.gsub("@", "-0-").gsub(".", "-")}- -p #{@port}"
      stdout, stderr, status = Open3.capture3(cmd)
      Rails.logger.info stdout
      Rails.logger.error stderr
    end
  end

  def port_destroy
    if current_user
      cmd = Rails.root.join('script', 'playground.sh').to_s + " -n u--#{current_user.email.gsub("@", "-0-").gsub(".", "-")}- -d"
      stdout, stderr, status = Open3.capture3(cmd)
      Rails.logger.info stdout
      Rails.logger.error stderr
      flag_destroy
    end
  end
end