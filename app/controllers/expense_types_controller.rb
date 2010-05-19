class ExpenseTypesController < ApplicationController
  # GET /expense_types
  # GET /expense_types.xml
  def index
    @expense_types = ExpenseType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_types }
    end
  end

  # GET /expense_types/1
  # GET /expense_types/1.xml
  def show
    @expense_type = ExpenseType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_type }
    end
  end

  # GET /expense_types/new
  # GET /expense_types/new.xml
  def new
    @expense_type = ExpenseType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_type }
    end
  end

  # GET /expense_types/1/edit
  def edit
    @expense_type = ExpenseType.find(params[:id])
  end

  # POST /expense_types
  # POST /expense_types.xml
  def create
    @expense_type = ExpenseType.new(params[:expense_type])
    @expense_type.user_id = session[:user_id]
    respond_to do |format|
      if @expense_type.save
        flash[:notice] = 'ExpenseType was successfully created.'
        format.html { redirect_to expense_types_url }
        format.xml  { render :xml => @expense_type, :status => :created, :location => @expense_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_types/1
  # PUT /expense_types/1.xml
  def update
    @expense_type = ExpenseType.find(params[:id])

    respond_to do |format|
      if @expense_type.update_attributes(params[:expense_type])
        flash[:notice] = 'ExpenseType was successfully updated.'
        format.html { redirect_to expense_types_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_types/1
  # DELETE /expense_types/1.xml
  def destroy
    @expense_type = ExpenseType.find(params[:id])
    @expense_type.destroy

    respond_to do |format|
      format.html { redirect_to(expense_types_url) }
      format.xml  { head :ok }
    end
  end
end
