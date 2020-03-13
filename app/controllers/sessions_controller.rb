class SessionsController < ApplicationController
  def new
  end
  
  def create
    use = User.find_by(email: params[:session][:email].downcase) # sessionの箱の中のemailを取り出す
    if user && user.authenticate(params[session][:password])
    else
      render :new
    end
  end
end
