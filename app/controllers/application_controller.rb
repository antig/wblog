class ApplicationController < ActionController::Base
  protect_from_forgery    

  helper_method :format_time, :format_date

  helper_method :admin_username

  def format_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def format_date(time)
    time.strftime("%Y.%m.%d")
  end
=begin
  def self.rescue_errors
     rescue_from ActionController::RoutingError,       :with => :render_not_found
     rescue_from ActionController::UnknownController,  :with => :render_not_found
     rescue_from ActionController::UnknownAction,      :with => :render_not_found
  end

  def render_not_found(excp = nil)
    render :template => "errors/404", :status => 404, :layout => 'public'
  end
=end
  protected
  def authericate_user!
    if ! session[:login]
      flash[:error] = '请先登录后台管理'
      cookies[:urlback] = request.original_url
      redirect_to new_admin_session_path
    end
  end

  def admin_username
    session[:login] && ENV['ADMIN_USER']
  end
end
