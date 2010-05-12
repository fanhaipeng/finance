class ExpenseTagsController < ApplicationController
  # GET /expense_tags
  # GET /expense_tags.xml
  def index
    @expense_tags = ExpenseTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expense_tags }
    end
  end

  # GET /expense_tags/1
  # GET /expense_tags/1.xml
  def show
    @expense_tag = ExpenseTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense_tag }
    end
  end

  # GET /expense_tags/new
  # GET /expense_tags/new.xml
  def new
    @expense_tag = ExpenseTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense_tag }
    end
  end

  # GET /expense_tags/1/edit
  def edit
    @expense_tag = ExpenseTag.find(params[:id])
  end

  # POST /expense_tags
  # POST /expense_tags.xml
  def create
    @expense_tag = ExpenseTag.new(params[:expense_tag])

    respond_to do |format|
      if @expense_tag.save
        flash[:notice] = 'ExpenseTag was successfully created.'
        format.html { redirect_to(@expense_tag) }
        format.xml  { render :xml => @expense_tag, :status => :created, :location => @expense_tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expense_tags/1
  # PUT /expense_tags/1.xml
  def update
    @expense_tag = ExpenseTag.find(params[:id])

    respond_to do |format|
      if @expense_tag.update_attributes(params[:expense_tag])
        flash[:notice] = 'ExpenseTag was successfully updated.'
        format.html { redirect_to(@expense_tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_tags/1
  # DELETE /expense_tags/1.xml
  def destroy
    @expense_tag = ExpenseTag.find(params[:id])
    @expense_tag.destroy

    respond_to do |format|
      format.html { redirect_to(expense_tags_url) }
      format.xml  { head :ok }
    end
  end
end
