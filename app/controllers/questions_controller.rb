class QuestionsController < ApplicationController
  before_action :load_question, only: %i[ show edit update destroy ]
  before_action :authorize_user, except: [:create]

  def edit
  end

  def create
    @question = Question.new(question_create_params)
    @question.author = current_user

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: t('.notice')
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params_update)
      redirect_to user_path(@question.user), notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: t('.notice')
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user if @question.user != current_user
  end

  def question_create_params
    params.require(:question).permit(:user_id, :text)
  end

  def question_params_update
    params.require(:question).permit(:user_id, :answer, :text)
  end

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end
end
