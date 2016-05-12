module ApplicationHelper
  def markdown(source)
    Kramdown::Document.new(source).to_html.html_safe
  end

  def flag_destroy(env=nil)
    if env.nil?
      session[:web][:level1] = nil
      session[:web][:level2] = nil
      session[:web][:level3] = nil
    else
      env['rack.session'][:web][:level1] = nil
      env['rack.session'][:web][:level2] = nil
      env['rack.session'][:web][:level3] = nil
    end
  end
end