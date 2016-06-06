module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source).to_html.html_safe
  end

  def flag_destroy(env=nil)
    if env.nil?
      if session.key? :web
        session[:web][:level1] = nil
        session[:web][:level2] = nil
        session[:web][:level3] = nil
        session[:web][:level4] = nil
        session[:web][:level5] = nil
      end
    else
      if env['rack.session'].key? :web
        env['rack.session'][:web][:level1] = nil
        env['rack.session'][:web][:level2] = nil
        env['rack.session'][:web][:level3] = nil
        env['rack.session'][:web][:level4] = nil
        env['rack.session'][:web][:level5] = nil
      end
    end
  end
end