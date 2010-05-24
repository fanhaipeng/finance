class AccountController < ApplicationController
  def login
    if request.post?
      user = 
        User.authenticate(params[:user][:username], params[:user][:password])
      if user
        session[:user_id] = user.id
        redirect_to expense_month_path(Date.today.year, Date.today.mon)
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => :login
  end
end

