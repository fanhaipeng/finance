# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :authenticate, :except => :login

protected

  def populate_expense_types
    @expense_types = ExpenseType.find(:all).map do |t|
      [t.description, t.id]
    end
  end

  def populate_expense_tags
    @expense_tags = ExpenseTag.find(:all)
  end

  def authenticate
    @user = User.find_by_id(session[:user_id])
    unless @user
      flash[:notice] = '请先登录'
      redirect_to :controller => :account, :action => :login
    end
  end
end
