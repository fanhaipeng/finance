class ExpenseItemsController < ApplicationController
  # GET /expense_items
  # GET /expense_items.xml
  def index
    @expense_items = ExpenseItem.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_items }
    end
  end

  # GET /expense_items/1
  # GET /expense_items/1.xml
  def show
    @expense_item = ExpenseItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_item }
    end
  end

  # GET /expense_items/new
  # GET /expense_items/new.xml
  def new
    @expense_item = ExpenseItem.new
    prepare_for Date.today.year, Date.today.mon
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_item }
    end
  end

  # GET /expense_items/1/edit
  def edit
    @expense_item = ExpenseItem.find(params[:id])
    prepare_for @expense_item.date.year, @expense_item.date.mon
  end

  # POST /expense_items
  # POST /expense_items.xml
  def create
    @expense_item = ExpenseItem.new(params[:expense_item])
    respond_to do |format|
      if @expense_item.save
        flash[:notice] = '成功创建消费记录！'
        format.html { redirect_to expense_month_url(
                          @expense_item.date.year, @expense_item.date.mon) }
        format.xml  { render :xml => @expense_item, :status => :created, :location => @expense_item }
      else
        prepare_for_new
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_items/1
  # PUT /expense_items/1.xml
  def update
    @expense_item = ExpenseItem.find(params[:id])

    respond_to do |format|
      if @expense_item.update_attributes(params[:expense_item])
        flash[:notice] = '成功更新消费记录！'
        format.html { redirect_to expense_month_url( 
                 @expense_item.date.year, @expense_item.date.mon ) }
        format.xml  { head :ok }
      else
        prepare_for_edit @expense_item.date.year, @expense_item.date.mon
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_items/1
  # DELETE /expense_items/1.xml
  def destroy
    @expense_item = ExpenseItem.find(params[:id])
    @expense_item.destroy

    respond_to do |format|
      format.html { redirect_to expense_month_url(
          Date.today.year, Date.today.mon) }
      format.xml  { head :ok }
    end
  end

protected

  def prepare_for year, month
    populate_expense_types
    populate_expense_tags
    @year = year
    @month = month
  end
end
