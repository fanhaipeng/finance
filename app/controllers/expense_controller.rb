class ExpenseController < ApplicationController

  before_filter :set_active_tab

  def index
    date_start, date_end = normalize_date
    @page_title = "#{date_start.year}年#{date_start.mon}月花销记录"
    @expense_items = 
      ExpenseItem.find(:all, 
                       :conditions => ["date BETWEEN ? and ?", date_start, date_end],
                       :order => "date DESC")
    @expense_total = 
      ExpenseItem.sum(:value,
                      :conditions => ["date BETWEEN ? and ?", date_start, date_end])
    @previous_month = date_start << 1
    @next_month = date_start >> 1
    @this_month = date_start
  end

  def batch_new
    @page_title = '批量创建花销记录'
    populate_expense_types
  end

  def batch_create
    success = true 
    date_from = Date.civil(params[:expense_items][:"date_from(1i)"].to_i,
                           params[:expense_items][:"date_from(2i)"].to_i,
                           params[:expense_items][:"date_from(3i)"].to_i)
    date_to = Date.civil(params[:expense_items][:"date_to(1i)"].to_i,
                          params[:expense_items][:"date_to(2i)"].to_i,
                          params[:expense_items][:"date_to(3i)"].to_i)                         
    if date_from <= date_to
      (date_from .. date_to).each do|day|
        @expense_item = ExpenseItem.new
        @expense_item.date = day
        @expense_item.user_id = session[:user_id]
        @expense_item.expense_type_id = params[:expense_items][:expense_type_id]
        @expense_item.value = params[:expense_items][:value]
        @expense_item.note = params[:expense_items][:note]
        success = @expense_item.save
        break unless success
      end
    else
      flash[:notice] = '结束时间不能早于起始时间'
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to expense_month_path(
           date_from.year, date_from.month)}
      else
        populate_expense_types
        format.html { render :action => 'batch_new' }
      end
    end
  end

protected

  def normalize_date
    if params[:year] and params[:month]
      [first_day_of_month(params[:year], params[:month]), 
       last_day_of_month(params[:year], params[:month])]
    else
      t = Date.today
      [first_day_of_month(t.year, t.mon),
       last_day_of_month(t.year, t.mon)]
    end
  end

  def last_day_of_month year, month
    first_day = Date.new(year.to_i, month.to_i, 1)
    first_day >>= 1
    first_day -= 1
  end

  def first_day_of_month year, month 
    Date.new(year.to_i, month.to_i, 1)
  end

  def set_active_tab
    @activetab = 1
  end
end
