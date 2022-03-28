class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'залогинились - отлично, идем дальше'
    else
      flash.now.alert = 'Почта не та или пароль не тот, давай еще разок'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'С возвращением в Зион Нео!'
  end
end
