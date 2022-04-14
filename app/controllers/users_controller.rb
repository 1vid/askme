class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_url, alert: t('.alert') if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: t('.alert') if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: t('.notice')
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: t('.notice')
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('.notice')
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.count(&:answer)
    @unanswered_count = @questions_count - @answers_count
  end

  private
  
  def authorize_user
    reject_user if @user != current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :name, :username, :avatar_url, :bg_color
    )
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
