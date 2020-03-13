class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase) # sessionの箱の中のemailを取り出す
    if user && user.authenticate(params[session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end
end
