class AccountController < ApplicationController

  layout "application"

  def login
    @page_title = '登录'
    if request.post?
      user = 
        User.authenticate(params[:user][:username], params[:user][:password])
      flash[:notice] = nil;
      if user
        session[:user_id] = user.id
        redirect_to expense_month_path(Date.today.year, Date.today.mon)
      else
        flash[:notice] = '用户名或密码不正确，请重试！'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => :login
  end
end

