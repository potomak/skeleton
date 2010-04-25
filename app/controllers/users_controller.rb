class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_same_user, :only => :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions"
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def resend_activation
    @user = User.find(params[:user_id])
    
    @user.deliver_activation_instructions!
    flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions"
    redirect_back_or_default root_url
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    flash[:notice] = "Account deleted"
    render(:update) { |page| page.redirect_to(root_url) }
  end
end
