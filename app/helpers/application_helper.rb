module ApplicationHelper
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
end