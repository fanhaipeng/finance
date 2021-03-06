class UsersController < ApplicationController

  skip_before_filter :authenticate, :only => [:new, :create]
  before_filter :set_active_tab
  before_filter :check_admin, :only => :index
  before_filter :check_identity

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @page_title = '用户列表'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @page_title = '用户基本信息'
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @page_title = '创建新用户'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @page_title = '更新用户信息'
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        @page_title = '创建新用户'
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if verify_old_password(@user) and @user.update_attributes(params[:user])
        flash[:notice] = '用户信息更新成功！'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        @page_title = '更新用户信息'
        if not @user.errors.full_messages.blank?
          flash[:notice] = @user.errors.full_messages
        else
          flash[:notice] = '旧密码不正确，请重试'
        end
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

private
  
  def verify_old_password user
    old_pass = params[:verify][:oldpass]
    pass = params[:user][:password]
    pass_confirm = params[:user][:password_confirmation]
    if old_pass.blank? and pass.blank? and pass_confirm.blank?
      true
    else
      if !old_pass.blank? and User.authenticate(user.email, old_pass)
        true
      else
        false
      end
    end
  end

  def set_active_tab
    @activetab = 4
  end

  def check_admin
    user = User.find_by_id(session[:user_id])
    if 0 != user.role
      render :file => "public/401.html", :status => :unauthorized
    end
  end

  def check_identity
    user = User.find_by_id(session[:user_id])
    if params[:id] and session[:user_id] != params[:id].to_i and 0 != user.role
      render :file => "public/401.html", :status => :unauthorized
    end
  end

end
