module SessionsHelper
  
  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    if session[:id]
      @current_user ||= User.find_by(id:session[:id])
    end
  end
      
end
