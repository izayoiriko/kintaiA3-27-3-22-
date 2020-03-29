class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit_basic_ad, :update_basic_ad]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit_basic_ad, :update_basic_ad]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info, :edit_basic_ad, :update_basic_ad]
  before_action :admin_or_corect_user, only: :show
  before_action :set_one_month, only: :show

  def index
    @users = params[:search].present? ? User.name_search(params[:search]) : User.all
    @users = @users.paginate(page: params[:page], per_page: 20)
  end
  
  def index_employees
  end
  
  def index_base
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user #user_url(@user)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def edit_basic_ad
    
  end 
  
  def update_basic_ad
    @users = User.all
    @users.each do |users|
       
      unless users.update_attributes(basic_ad_params)
        flash[:danger] = "更新できませんでした。<br>" + @user.errors.full_messages.join("<br>")
        
        render 'edit_basic_ad' and return
      else
      end
    end
    flash[:success] = "更新できました"
    redirect_to user_url(@user)
  end
  
  def edit_over_time
  end
  
  def new_over_time
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
    
    def basic_ad_params
      params.require(:user).permit(:basic_time, :work_time)
    end
end
