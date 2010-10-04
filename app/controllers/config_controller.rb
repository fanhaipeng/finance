class ConfigController < ApplicationController
  before_filter :set_active_tab

  def index
    @expense_types = ExpenseType.find_all_by_user_id(session[:user_id])
    @expense_tags = ExpenseTag.find_all_by_user_id(session[:user_id])
  end

  def new_type
    @expense_type = ExpenseType.new(params[:expense_type])
    @expense_type.user_id = session[:user_id]
    respond_to do |format|
      if !@expense_type.save
        flash[:notice] = '创建新消费类型失败'
      end
      format.html { redirect_to config_action_url }
    end
  end

  private

  def set_active_tab
    @activetab = 4
  end

end
